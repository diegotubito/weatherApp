//
//  ChosenCityListViewModelContract.swift
//  weatherApp
//
//  Created by Gomez David Diego on 06/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation


protocol ChosenCityListViewModelContract {
    init(withView view: ChosenCityListViewContract, services: ServiceManager)
    var model : ChosenCityListModel! {get}
    func loadStoreCities()
    
}

protocol ChosenCityListViewContract {
    func showLoading()
    func hideLoading()
    func showError(_ errorMessage: String)

}
