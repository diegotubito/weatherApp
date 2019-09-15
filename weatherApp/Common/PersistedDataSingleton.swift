//
//  PersistedDataSingleton.swift
//  weatherApp
//
//  Created by Gomez David Diego on 14/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation

class PersistedDataManager {
    static let shared = PersistedDataManager()
    
    static func removeCitiesFromUserDefault() {
        UserDefaults.standard.set(nil, forKey: DefaultLocation.persistedCities)
    }
    
    static func loadPersistedCities() -> [City] {
        if let cities = UserDefaults.standard.object(forKey: DefaultLocation.persistedCities) as? [[String: Any]] {
            
            do {
                let data = try JSONSerialization.data(withJSONObject: cities, options: [])
                let registers = try JSONDecoder().decode([City].self, from: data)
                return registers
                
            } catch {
                print("errorr")
            }
        }
        
        return [City]()
    }
    
    static func saveCities(cities: [City]) {
        let decodedCities = PersistedDataManager.decodeCities(cities: cities)
        UserDefaults.standard.set(decodedCities, forKey: DefaultLocation.persistedCities)
    }
    
    
    private static func decodeCities(cities: [City]) -> [[String : Any]] {
        var result = [[String:Any]]()
        
        for city in cities {
            var reg = [String : Any]()
            reg["city_name"] = city.city_name
            reg["country_code"] = city.country_code
            reg["country_name"] = city.country_name
            reg["id"] = city.id
            reg["state_name"] = city.state_name
            
            result.append(reg)
        }
        
        return result
    }
    
}
