//
//  DetailViewController.swift
//  weatherApp
//
//  Created by Gomez David Diego on 06/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var viewModel : DetailViewModelContract!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        navigationItem.title = "NAV_TITLE_DETAIL".localized
    }
    
}


extension DetailViewController: DetailViewContract {
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}
