//
//  DetailViewModelContract.swift
//  weatherApp
//
//  Created by Gomez David Diego on 06/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation

protocol DetailViewModelContract {
    init(withView view: DetailViewContract)
    
    var model : DetailModel! {get}
}

protocol DetailViewContract {
    func showLoading()
    func hideLoading()
}
