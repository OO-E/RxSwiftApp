//
//  ErrorGenerator.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 28.02.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import Foundation

class ErrorGenerator {
    
    static var jsonModelString = """
                                        {
                                            "cod":"[COD]",
                                            "message":0.0,
                                            "cnt":40,
                                            "list":[],
                                            "city":{},
                                            "country":"",
                                            "population":0,
                                            "error":{
                                                "code":[COD],
                                                "message":"[ERROR_MESSAGE]"
                                                    }
                                        }
                                    """
    
    static func generateResultWithError(error: String) -> Data {
        
        if(error.contains("401")){
            jsonModelString = jsonModelString.replacingOccurrences(of: "[COD]", with: "401").replacingOccurrences(of: "[ERROR_MESSAGE]", with: "Unauthorized Request")
        }
        else if(error.contains("404")){
            jsonModelString = jsonModelString.replacingOccurrences(of: "[COD]", with: "404").replacingOccurrences(of: "[ERROR_MESSAGE]", with: "Not Found")
        }
        if(error.contains("500")){
            jsonModelString = jsonModelString.replacingOccurrences(of: "[COD]", with: "500").replacingOccurrences(of: "[ERROR_MESSAGE]", with: "Internal Server Error")
        }
        else {
            jsonModelString = jsonModelString.replacingOccurrences(of: "[COD]", with: "501").replacingOccurrences(of: "[ERROR_MESSAGE]", with: "Unkown Error")
        }
        return jsonModelString.data(using: .utf8)!
    }
    
}
