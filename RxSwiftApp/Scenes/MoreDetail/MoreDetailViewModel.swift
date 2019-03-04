//
//  MoreDetailViewModel.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 1.03.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import RxSwift
import RxCocoa

final class MoreDetailViewModel: ViewModelType {
    struct Input {
        let ready: Driver<Void>
        let backTrigger: Driver<Void>
    }
    
    struct Output {
        let result: Driver<ListItem?>
        let back: Driver<Void>
    }
    
    struct Dependencies {
        let result: ListItem
        let navigator: MoreDetailNavigatable
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: MoreDetailViewModel.Input) -> MoreDetailViewModel.Output {
        let result = input.ready
            .asObservable()
            .map {_ in
                return self.dependencies.result
            }
            .asDriver(onErrorJustReturn: nil)
        
        let back = input.backTrigger
            .do(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.dependencies.navigator.closePopUp()
                
            })
        
        return Output(result:result, back: back)
    }
}
