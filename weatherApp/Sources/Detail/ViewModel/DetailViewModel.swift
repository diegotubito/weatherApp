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

    
    required init(withView view: DetailViewContract) {
        _view = view
        model = DetailModel()
    }
 
    
}
