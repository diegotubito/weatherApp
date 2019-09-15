//
//  Service.swift
//  weatherApp
//
//  Created by Gomez David Diego on 01/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//


import UIKit
import Foundation

enum ServiceError : Error{
    case unableToDecodeData
    case unableToOpenFile
    case unknownError
}

class ServiceManager: ServiceManagerProtocol {
    
    public typealias completionAlias = ([[String:Any]]) -> ()
    public typealias failAlias =  (String) -> ()
    
    func retrieveFromJSONFile(name: String, completion: completionAlias, fail: failAlias) {
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: Any]] {
                    // do stuff
                    completion(jsonResult)
                }
            } catch {
                // handle error
                fail(error.localizedDescription)
            }
        }
    }
   
    
    
    func retrieveJSON(url: String, result: @escaping([String : Any]?, Error?) -> Void){
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
                result(json, nil)
            } catch {
                result(nil, error)
            }
            
        })
        task.resume()
    }
    
}

