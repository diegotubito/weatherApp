//
//  AddCityViewModelContract.swift
//  weatherApp
//
//  Created by Gomez David Diego on 08/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation

protocol AddCityViewModelContract {
    init (withView view: AddCityViewContract)
    var model : AddCityModel! {get}
    func searchCities()
    func filterList(text: String)
}

protocol AddCityViewContract {
    func showLoading()
    func hideLoading()
    func showEmptyList()
    func showError(_ value: String)
    func reloadList()
}
