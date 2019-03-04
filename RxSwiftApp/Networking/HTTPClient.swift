//
//  HTTPClient.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 21.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import RxSwift
import RxCocoa

protocol HTTPClientProvider {
    func get(url: String) -> Observable<Data?>
    func post(url: String, params: [String: Any]) -> Observable<Data?>
}

final class HTTPClient: HTTPClientProvider {
    func get(url: String) -> Observable<Data?> {
        guard let url = URL(string: url) else { return Observable.empty() }
        let request = URLRequest(url: url)
        return URLSession.shared.rx.data(request: request)
            .filter{ data in
                print("\n\n------ Response Model ------\n\((String(data: data, encoding: String.Encoding.utf8))!)")
                return true
            }
            .map { Optional.init($0) }
            .catchError({ error in
                print("\n\n------ Error ------\n\(error)")
                return Observable.just(ErrorGenerator.generateResultWithError(error: "\(error)"))
            })
    }
    
    func post(url: String, params: [String: Any]) -> Observable<Data?> {
        guard let url = URL(string: url) else { return Observable.empty() }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        request.httpBody = jsonData
        return URLSession.shared.rx.data(request: request)
            .filter{ data in
                print("\n\n------ Response Model ------\n\((String(data: data, encoding: String.Encoding.utf8))!)")
                return true
            }
            .map { Optional.init($0) }
            .catchError{ error in
                print("\n\n------ Error ------\n\(error)")
                return Observable.just(ErrorGenerator.generateResultWithError(error: "\(error)"))
            }
    }
}
