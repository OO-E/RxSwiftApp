//
//  ClientApi.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 21.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ClientApiWeatherProvider {
    func fetchGetWeather(forCityName cityName: String) -> Observable<Result?>
}

protocol ClientApiProvider: ClientApiWeatherProvider { }

final class ClientApi: ClientApiProvider {
    private struct Constants {
        static let baseURL: String = "http://api.openweathermap.org/data/2.5/"
        static let apiKey = "8827fbf408dc7e1418f3c1e84596334c"
        static let iconURL: String = "https://openweathermap.org/img/w/ICON_NAME.png"
    }
    
    private let httpClient: HTTPClientProvider
    
    init(httpClient: HTTPClientProvider = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func fetchGetWeather(forCityName cityName: String) -> Observable<Result?> {
        return httpClient.post(url: "\(Constants.baseURL)\("forecast?q=\(cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? cityName)&units=metric&APPID=\(Constants.apiKey)")", params: [:])
            .map { data -> Result? in
                
                guard let data = data,
                    let response = try? JSONDecoder().decode(Result.self, from: data) else {
                        return nil
                }
                return response
        }
    }
}
