//
//  ViewController.swift
//  weatherApp
//
//  Created by Gomez David Diego on 31/08/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation
import UIKit

class MainViewController : UIViewController {
    
    override func viewDidLoad() {
        super .viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Home"
        
    }
    
    @IBAction func startTestPressed(_ sender: Any) {
        performSegue(withIdentifier: "segue_to_chosen_city_list", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super .prepare(for: segue, sender: sender)
        
        if let controller = segue.destination as? ChosenCityListViewController {
            controller.viewModel = ChosenCityListViewModel(withView: controller, services: ServiceManager())
            
        }
    }
    
}

