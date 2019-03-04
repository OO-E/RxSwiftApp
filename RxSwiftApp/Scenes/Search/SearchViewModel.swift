//
//  SearchViewModel.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 21.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import RxSwift
import RxCocoa

final class SearchViewModel: ViewModelType {
    
    struct Input {
        let searchText: Driver<String>
        let selected: Driver<IndexPath>
        let searchTaps: Signal<Void>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let results: Driver<[Result]>
        let selectedDone: Driver<Void>
    }
    
    struct Dependencies {
        let api: ClientApiProvider
        let navigator: SearchNavigatable
    }
    
    private let dependencies: Dependencies
    private var searchArray: [Result] = [Result]()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: SearchViewModel.Input) -> SearchViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let loading = activityIndicator.asDriver()
        
        let resultsSearch = input.searchText
            .filter { $0.count >= 3 }
            .asObservable()
            .map { text -> [Result] in
                return self.filterArray(withSeacrhText: (text))
        }
        
        let searchForm = input.searchText
            .asObservable()
        
        let results = input.searchTaps
            .asObservable()
            .withLatestFrom(searchForm)
            .filter { text in
                return text.count >= 3 && self.searchArray.filter({$0.city?.name!.lowercased().uppercased() == text.lowercased().uppercased()}).count == 0
            }
            .flatMapLatest { text -> Observable<[Result]> in
                let searchText = text
                return self.dependencies.api.fetchGetWeather(forCityName: searchText)
                    .trackActivity(activityIndicator)
                    .map { result -> [Result] in
                        guard let result = result else {
                            return []
                        }
                        
                        if (result.error != nil) {
                            return [result]
                        }
                        else if self.searchArray.filter({$0.city?.name == result.city?.name}).count == 0 {
                            self.searchArray.append(result)
                        }
                        
                        return self.filterArray(withSeacrhText: (result.city?.name)!)
                }
            }
            .asDriver(onErrorJustReturn: [])
            .asObservable()
        
        let emptyResults =  input.searchText
            .asObservable()
            .filter { $0.count < 3 }
            .map { _ in return self.searchArray }
        
        let mappedResults = Observable.merge(results, emptyResults, resultsSearch)
            .map { $0.map { $0 }}
            .asDriver(onErrorJustReturn: [])
        
        let selectedDone = input.selected
            .asObservable()
            .withLatestFrom(Observable.merge(results, emptyResults, resultsSearch)) { indexPath, results in
                return (results.count > indexPath.row) ? results[indexPath.row] : nil
            }
            .do(onNext: { [weak self] result in
                guard let strongSelf = self else { return }
                if(result != nil && result?.error == nil) {
                    strongSelf.dependencies.navigator.navigateToWeatherDetailScreen(withModel: result!)
                }
            })
            .map { _ in return () }
            .asDriver(onErrorJustReturn: ())
        
        return Output(loading: loading,
                      results: mappedResults,
                      selectedDone: selectedDone)
    }
    
    func filterArray(withSeacrhText searchText: String) -> [Result] {
        return self.searchArray.filter{ (model : Result) -> Bool in
            return (model.city?.name!.lowercased().replacingOccurrences(of: "ı", with: "i").replacingOccurrences(of: "ü", with: "u").replacingOccurrences(of: "ş", with: "s").replacingOccurrences(of: "ç", with: "c").replacingOccurrences(of: "ö", with: "o").replacingOccurrences(of: "ğ", with: "g").contains(searchText.lowercased().replacingOccurrences(of: "ı", with: "i").replacingOccurrences(of: "ü", with: "u").replacingOccurrences(of: "ş", with: "s").replacingOccurrences(of: "ç", with: "c").replacingOccurrences(of: "ö", with: "o").replacingOccurrences(of: "ğ", with: "g")))! }
    }
}
