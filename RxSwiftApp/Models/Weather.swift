//
//  Weather.swift
//  MobvenWeatherApp
//
//  Created by Gökhan Aydın on 26.10.2018.
//  Copyright © 2018 Gökhan Aydın. All rights reserved.
//

import Foundation

class Weather : Codable {
    
    var id : Int?
    var main : String?
    var modelDescription : String?
    var icon : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case modelDescription = "description"
        case icon = "icon"
    }
    
}
