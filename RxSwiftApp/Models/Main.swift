//
//  Main.swift
//  MobvenWeatherApp
//
//  Created by Gökhan Aydın on 26.10.2018.
//  Copyright © 2018 Gökhan Aydın. All rights reserved.
//

import Foundation

class Main : Codable {
    
    var temp : Float?
    var temp_min : Float?
    var temp_max : Float?
    var pressure : Float?
    var sea_level : Float?
    var grnd_level : Float?
    var humidity : Float?
    var temp_kf : Float?
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
        case humidity = "humidity"
        case temp_kf = "temp_kf"
    }
    
}
