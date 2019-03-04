//
//  Result.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 21.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import Foundation

class Result : Codable {
    
    var cod: String?
    var message: Float?
    var cnt: Int?
    var list: [ListItem]
    var city: City?
    var error : ClientError?
    
    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
        case error = "error"
    }
}
