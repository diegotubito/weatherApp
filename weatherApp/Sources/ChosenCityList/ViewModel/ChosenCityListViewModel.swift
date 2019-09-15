//
//  ChosenCityListViewModel.swift
//  weatherApp
//
//  Created by Gomez David Diego on 06/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation

class ChosenCityListViewModel: ChosenCityListViewModelContract {
  
    
    var model: ChosenCityListModel!
    var _view : ChosenCityListViewContract!
    var _service : ServiceManager!
    
    required init(withView view: ChosenCityListViewContract, services: ServiceManager) {
        _view = view
        _service = services
        
        model = ChosenCityListModel()
    }
    
    func loadStoreCities() {
        let cities = PersistedDataManager.loadPersistedCities()
        model.cities = cities
        getCurrentTemperature()
    }
    
    func getCurrentTemperature() {
        
        for (x,city) in model.cities.enumerated() {
            let id = String(city.id ?? 0)
            
            let url = "https://api.weatherbit.io/v2.0/current?city_id=\(id)&key=\(API_KEY)"
            
            _service.retrieveJSON(url: url) { (json, error) in
                
                guard error == nil else {
                    self._view.showError(error?.localizedDescription ?? "unknown error")
                    return
                }
                
                guard let jsonConverted = json?["data"] as? [[String : Any]] else {
                    self._view.showError("There's no data")
                    return
                }
       
                if jsonConverted.count > 0 {
                    if let temp = jsonConverted[0]["app_temp"] as? Double {
                        self.model.cities[x].temp = temp
                        self._view.reloadList()
                    }
                }
            }
        }
    }
    
    func addNewCity(_ value: City) {
        
        if validateNewCity(value) {
            model.cities.append(value)
            self._view.reloadList()
            
            PersistedDataManager.saveCities(cities: model.cities)
            getCurrentTemperature()
        }
    }
    
  
    
    private func validateNewCity(_ value: City) -> Bool {
        let result = model.cities.contains(where: {$0.id == value.id})
    
        return !result
    }
    
    func getSelectedCity(index: Int) -> City {
        return model.cities[index]
    }
    
    func resetCityTemp() {
        
        let cities = model.cities
        for (x,_) in cities.enumerated() {
            model.cities[x].temp = nil
        }
        self._view.reloadList()
        
    }
    
}
