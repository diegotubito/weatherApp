//
//  common.swift
//  weatherApp
//
//  Created by Gomez David Diego on 11/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation

let API_KEY = "967037fb2a1748ef877401ae19fc45c1"
let EXTENDED_DAYS = 16

struct DefaultLocation {
    static let persistedCities = "persisted_cities"
}

struct City: Decodable {
    var state_name : String?
    var city_name : String?
    var country_name : String?
    var country_code : String?
    var id : Int?
    
    var temp : Double?
}

struct MainData: Decodable {
    var humidity: Int?
    var pressure : String?
    var temp : String?
}

struct WeatherGeneral: Decodable {
    var temp : Double?
    var max_temp : Double?
    var min_temp : Double?
    var datetime : String?
 
    struct Weather: Decodable {
        var description : String?
        var icon : String?
    }
    
    var weather = Weather()
 
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
