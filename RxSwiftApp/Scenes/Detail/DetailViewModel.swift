//
//  DetailViewModel.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 27.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import RxSwift
import RxCocoa

final class DetailViewModel: ViewModelType {
    struct Input {
        let ready: Driver<Void>
        let backTrigger: Driver<Void>
        let selected: Driver<IndexPath>
    }
    
    struct Output {
        let result: Driver<Result?>
        let list: Driver<[ListItem]>
        let back: Driver<Void>
        let selectedDone: Driver<Void>
        
    }
    
    struct Dependencies {
        let result: Result
        let navigator: DetailNavigatable
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: DetailViewModel.Input) -> DetailViewModel.Output {
        let result = input.ready
            .asObservable()
            .map {_ in
                return self.dependencies.result
            }
            .asDriver(onErrorJustReturn: nil)
        
        let list = input.ready
            .asObservable()
            .map {_ in
                return self.dependencies.result.list
            }
            .asDriver(onErrorJustReturn: [])
        
        let back = input.backTrigger
            .do(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.dependencies.navigator.goBack()
                
            })
        
        let selectedDone = input.selected
            .asObservable()
            .withLatestFrom(Observable.of(self.dependencies.result.list)) { indexPath, results in
                return (results.count > indexPath.row) ? results[indexPath.row] : nil
            }
            .do(onNext: { [weak self] result in
                guard let strongSelf = self else { return }
                strongSelf.dependencies.navigator.navigateToWeatherMoreDetailScreen(withModel: result!)
            })
            .map { _ in return () }
            .asDriver(onErrorJustReturn: ())
        
        return Output(result:result, list: list, back: back, selectedDone : selectedDone)
    }
}
