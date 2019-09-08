//
//  Service.swift
//  weatherApp
//
//  Created by Gomez David Diego on 01/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//


import UIKit
import Foundation

class ServiceManager {
    //variable for storing images in cache, to improve performance and efficiency.
    var imageCache = NSCache<AnyObject, AnyObject>()
}

enum ServiceError : Error{
    case unableToDecodeData
    case unableToOpenFile
    case unknownError
}
/*
{
    base = stations;
    clouds =     {
        all = 0;
    };
    cod = 200;
    coord =     {
        lat = "-27.78";
        lon = "-67.23999999999999";
    };
    dt = 1567454815;
    id = 3846616;
    main =     {
        "grnd_level" = "849.49";
        humidity = 30;
        pressure = "1016.15";
        "sea_level" = "1016.15";
        temp = "288.4";
        "temp_max" = "288.4";
        "temp_min" = "288.4";
    };
    name = Cordoba;
    sys =     {
        country = AR;
        message = "0.0056";
        sunrise = 1567420921;
        sunset = 1567462551;
    };
    timezone = "-10800";
    weather =     (
        {
            description = "clear sky";
            icon = 01d;
            id = 800;
            main = Clear;
        }
    );
    wind =     {
        deg = "68.94799999999999";
        speed = "7.15";
    };
}
 
*/

extension ServiceManager: ServiceManagerProtocol {
    
    struct Weather : Decodable {
        var id: Int?
        var name : String?
        
        var main = MainData()
        
    }
    
    struct MainData: Decodable {
        var humidity: Int?
        var pressure : String?
        var temp : String?
    }
    
    struct Wind: Decodable {
        var deg : String?
        var speed : String?
    }
   
    func retrieveData(url: String, result: @escaping(ServiceManager.Weather?, Error?) -> Void){
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            guard error == nil else {
                result(nil, error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                
                let parsedData = self.parse(json)
                
                let a = try JSONDecoder().decode(ServiceManager.Weather.self, from: data)
                print(a.name)
                print(a.main.humidity)
                result(parsedData, nil)
            } catch {
                result(nil, error)
            }
            
        })
        task.resume()
    }
    
    private func parse(_ json: [String : Any]?) -> Weather? {
        guard json != nil else {
            return nil
        }
        
        var result = Weather()
        result.name = json?["name"] as? String
        result.id = json?["id"] as? Int
        if let main = json?["main"] as? [String: Any] {
            for (key,value) in main {
                if key == "pressure" {
                    result.main.pressure = value as? String
                }
            }
        }
        return result
        
    }
}

