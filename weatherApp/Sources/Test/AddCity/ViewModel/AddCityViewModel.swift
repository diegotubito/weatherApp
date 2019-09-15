//
//  AddCityViewModel.swift
//  weatherApp
//
//  Created by Gomez David Diego on 08/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation

class AddCityViewModel: AddCityViewModelContract {
    
    var model: AddCityModel!
    var _view : AddCityViewContract!
    var _service : ServiceManager!
    
    required init(withView view: AddCityViewContract) {
        _view = view
        _service = ServiceManager()
        model = AddCityModel()
    }
    
    func searchCities() {
        let backgroundQueue = DispatchQueue(label: "Loading Cities", qos: .background)
        
        backgroundQueue.async {
            print("Run on background thread")
            
            self._view.showLoading()
            
            self._service.retrieveFromJSONFile(name: "cities_20000", completion: { (responseJSON) in
                self._view.hideLoading()
                
                let data = try! JSONSerialization.data(withJSONObject: responseJSON, options: [])
                let registros = try! JSONDecoder().decode([City].self, from: data)
                self.model.registers = registros
                
                self.model.filteredRegisters = registros
                self._view.reloadList()
            }, fail: { (errorMessage) in
                self._view.hideLoading()
                self._view.showError(errorMessage)
            })
        }
        
    }
    
    func filterList(text: String) {
        
        let cleanText = text.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
        
        let filetered = model.registers.filter({$0.city_name?.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current) == cleanText})
        if filetered.isEmpty {
            model.filteredRegisters.removeAll()
        } else {
            model.filteredRegisters = filetered
        }
        _view.reloadList()
 
    }
    
}

