//
//  DetailViewModelContract.swift
//  weatherApp
//
//  Created by Gomez David Diego on 06/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation

protocol DetailViewModelContract {
    init(withView view: DetailViewContract, service: ServiceManager)
    
    var model : DetailModel! {get}
    func setSelectedRegister(_ value: City)
    func loadExtended(days: Int) 
}

protocol DetailViewContract {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
    func showSuccess()
    
}
