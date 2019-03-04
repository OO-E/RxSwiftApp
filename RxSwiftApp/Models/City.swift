//
//  City.swift
//  MobvenWeatherApp
//
//  Created by Gökhan Aydın on 26.10.2018.
//  Copyright © 2018 Gökhan Aydın. All rights reserved.
//

import Foundation

class City : Codable{
    
    var id : Int?
    var name : String?
    var coord : Coord?
    var country : String?
    var population : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case coord = "coord"
        case country = "country"
        case population = "population"
    }
    
}
