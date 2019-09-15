//
//  DetailViewModel.swift
//  weatherApp
//
//  Created by Gomez David Diego on 06/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation


class DetailViewModel: DetailViewModelContract {
    
    
    var model: DetailModel!
    var _view : DetailViewContract!
    var _service : ServiceManager!

    
    required init(withView view: DetailViewContract, service: ServiceManager) {
        _view = view
        _service = service
        model = DetailModel()
    }
 
    func setSelectedRegister(_ value: City) {
        model.selectedRegister = value
    }
    
    func loadExtended(days: Int) {
        let id = model.selectedRegister.id ?? 0
        let url = "https://api.weatherbit.io/v2.0/forecast/daily?&units=M&days=\(days)&city_id=\(String(id))&key=\(API_KEY)"
        
        _view.showLoading()
        _service.retrieveJSON(url: url) { (json, error) in
            self._view.hideLoading()
            
            guard error == nil else {
                self._view.showError(error?.localizedDescription ?? "unknown error")
                return
            }
            
            guard let jsonConverted = json?["data"] as? [[String : Any]] else {
                self._view.showError("There's no data")
                return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: jsonConverted, options: [])
                self.model.registers = try JSONDecoder().decode([WeatherGeneral].self, from: data)
                
                self._view.showSuccess()
                
            } catch {
                self._view.showError(error.localizedDescription)
      
            }
        }
    }
    
    
}
