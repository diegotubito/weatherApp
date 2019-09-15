//
//  ChosenCityListViewModel.swift
//  weatherApp
//
//  Created by Gomez David Diego on 06/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation

class CityListViewModel: CityListViewModelContract {
  
    
    var model: CityListModel!
    var _view : CityListViewContract!
    var _service : ServiceManager!
    
    required init(withView view: CityListViewContract, services: ServiceManager) {
        _view = view
        _service = services
        
        model = CityListModel()
    }
    
    func loadStoreCities() {
        let cities = PersistedDataManager.loadPersistedCities()
        model.cities = cities
    }
    
    func getCurrentTemp(id: Int, success: @escaping (Double) -> (), fail: @escaping (String) -> ()) {
        
        let url = "\(API_URL)/current?city_id=\(String(id))&key=\(API_KEY)"
        
        _service.retrieveJSON(url: url) { (json, error) in
            
            guard error == nil else {
                fail(error?.localizedDescription ?? "")
                return
            }
            
            guard json?["error"] == nil else {
                let message = (json?["error"] as? String) ?? ""
                fail(message)
                return
            }
            
            guard let jsonConverted = json?["data"] as? [[String : Any]] else {
                let message = (json?["status_message"] as? String) ?? "No Data Available"
                fail(message)
                return
            }
            
            if jsonConverted.count > 0 {
                if let temp = jsonConverted[0]["app_temp"] as? Double {
    
                    success(temp)
                    return
                }
            }
            fail("unknown error")
        }
    }
    
    func addNewCity(_ value: City, finished: (Bool) -> ()) {
        
        if validateNewCity(value) {
            model.cities.append(value)
            PersistedDataManager.saveCities(cities: model.cities)
            finished(true)
        }
        finished(false)
    }
    
  
    
    private func validateNewCity(_ value: City) -> Bool {
        let result = model.cities.contains(where: {$0.id == value.id})
    
        return !result
    }
    
    func getSelectedCity(index: Int) -> City {
        return model.cities[index]
    }
    
    
}
