//
//  ClientError.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 25.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import Foundation

class ClientError : Error, Codable {
    
    var code: Int?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message = "message"
    }
}
