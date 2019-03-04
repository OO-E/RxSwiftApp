//
//  ListItem.swift
//  MobvenWeatherApp
//
//  Created by Gökhan Aydın on 26.10.2018.
//  Copyright © 2018 Gökhan Aydın. All rights reserved.
//

import Foundation

class ListItem : Codable {
    
    var dt : Int?
    var main : Main?
    var weather : [Weather]?
    var clouds : Clouds?
    var wind : Wind?
    var rain : Rain?
    var sys : Sys?
    var dt_txt : String?
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case wind = "wind"
        case rain = "rain"
        case sys = "sys"
        case dt_txt = "dt_txt"
    }
    
}
