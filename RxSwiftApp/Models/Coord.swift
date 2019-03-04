//
//  Coord.swift
//  MobvenWeatherApp
//
//  Created by Gökhan Aydın on 26.10.2018.
//  Copyright © 2018 Gökhan Aydın. All rights reserved.
//

import Foundation

class Coord : Codable {
    
    var lat : Double?
    var lon : Double?
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
    }
    
}
