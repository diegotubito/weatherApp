//
//  ChosenCityList.swift
//  weatherApp
//
//  Created by Gomez David Diego on 06/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation
import UIKit

class ChosenCityListViewController: UIViewController {
  
    var viewModel : ChosenCityListViewModelContract!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        //Loader init, used when loading from the internet.
        loaderInitialization()
        
        addPlusButton()
        
        //load store cities from UserDefaults
        viewModel.loadStoreCities()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        navigationItem.title = "NAV_TITLE_CITY_LIST".localized
    }
    
    func loaderInitialization() {
        //Just change bar colors to blue
        DDBarLoader.color = .blue
        DDBarLoader.barWidth = 10
        DDBarLoader.numberOfBars = 3
        DDBarLoader.backgroundAlpha = 1
        DDBarLoader.roundedCap = true
    }
    
    func addPlusButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonHandler))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func addButtonHandler() {
        performSegue(withIdentifier: "segue_to_add_city", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super .prepare(for: segue, sender: sender)
        
        if let controller = segue.destination as? DetailViewController {
            controller.viewModel = DetailViewModel(withView: controller)
        }
        
        if let controller = segue.destination as? AddCityViewController {
            controller.viewModel = AddCityViewModel(withView: controller)
        }
    }
}


extension ChosenCityListViewController: ChosenCityListViewContract {
    func showLoading() {
        DispatchQueue.main.async {
            DDBarLoader.showLoading(controller: self, message: "")
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            DDBarLoader.hideLoading()
        }
    }
    
    func showError(_ errorMessage: String) {
        
    }
    
    
}
