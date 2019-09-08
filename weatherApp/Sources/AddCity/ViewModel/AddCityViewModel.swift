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
    
    
    
}
