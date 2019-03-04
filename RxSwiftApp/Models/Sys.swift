//
//  Sys.swift
//  MobvenWeatherApp
//
//  Created by Gökhan Aydın on 26.10.2018.
//  Copyright © 2018 Gökhan Aydın. All rights reserved.
//

import Foundation

class Sys : Codable {
    
    var pod : String?
    
    enum CodingKeys: String, CodingKey {
        case pod = "pod"
    }
    
}
