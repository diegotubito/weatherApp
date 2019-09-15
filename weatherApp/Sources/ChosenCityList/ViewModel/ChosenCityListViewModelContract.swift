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
    func addNewCity(_ value: City)
    func getSelectedCity(index: Int) -> City
    func resetCityTemp()
    
}

protocol ChosenCityListViewContract {
    func showLoading()
    func hideLoading()
    func showError(_ errorMessage: String)
    func reloadList()

}
