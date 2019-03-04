//
//  Clouds.swift
//  MobvenWeatherApp
//
//  Created by Gökhan Aydın on 26.10.2018.
//  Copyright © 2018 Gökhan Aydın. All rights reserved.
//

import Foundation

class Clouds : Codable {
    
    var all : Int?
    
    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
    
}
