//
//  Wind.swift
//  MobvenWeatherApp
//
//  Created by Gökhan Aydın on 26.10.2018.
//  Copyright © 2018 Gökhan Aydın. All rights reserved.
//

import Foundation

class Wind : Codable {
    
    var speed : Float?
    var deg : Double?
    
    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
    }
    
}
