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
    }
    
    func loadStoreCities() {
        let backgroundQueue = DispatchQueue(label: "Loading Cities", qos: .background)
        
        backgroundQueue.async {
            print("Run on background thread")
            
            self._view.showLoading()
            
            let url = "https://api.openweathermap.org/data/2.5/weather?q=Cordoba,ar&APPID=9db6c3acad9c6e42188f966a6596ddc9"
            self._service.retrieveData(url: url) { (data, error) in
                
                self._view.hideLoading()
                
                guard let data = data else {
                    return
                }
                
                print(data.name)
                //        print(data.main.pressure)
            }
        }
        
        
        
    }
}
