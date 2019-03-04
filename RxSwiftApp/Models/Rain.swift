//
//  Rain.swift
//  MobvenWeatherApp
//
//  Created by Gökhan Aydın on 26.10.2018.
//  Copyright © 2018 Gökhan Aydın. All rights reserved.
//

import Foundation

class Rain : Codable {
    
    var model3h : Float?
    
    enum CodingKeys: String, CodingKey {
        case model3h = "model3h"
    }
    
}
