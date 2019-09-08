//
//  AddCityViewController.swift
//  weatherApp
//
//  Created by Gomez David Diego on 08/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation
import UIKit

class AddCityViewController: UIViewController {
    
    var viewModel : AddCityViewModelContract!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        navigationItem.title = "NAV_TITLE_ADD_CITY".localized
    }
    
}

extension AddCityViewController: AddCityViewContract {
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    
}
