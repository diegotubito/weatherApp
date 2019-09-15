//
//  ChosenCityListViewModelContract.swift
//  weatherApp
//
//  Created by Gomez David Diego on 06/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation


protocol CityListViewModelContract {
    init(withView view: CityListViewContract, services: ServiceManager)
    var model : CityListModel! {get}
    func loadStoreCities()
    func addNewCity(_ value: City, finished: (Bool) -> ())
    func getSelectedCity(index: Int) -> City
    func getCurrentTemp(id: Int, success: @escaping (Double) -> (), fail: @escaping (String) -> ())
    
}

protocol CityListViewContract {
    func showLoading()
    func hideLoading()
    func showError(_ errorMessage: String)
    func reloadList()

}
