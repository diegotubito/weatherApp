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
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : AddCityViewModelContract!
    var onSelectedCity : ((City) -> ())?
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        registerCells()
        
        viewModel.searchCities()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        navigationItem.title = "Add New City"
    }
    
    func registerCells() {
        tableView.register(RegisterCityCell.nib, forCellReuseIdentifier: RegisterCityCell.identifier)
    }
    
}

extension AddCityViewController: AddCityViewContract {
    func reloadList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
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
    
    func showEmptyList() {
        
    }
    
    func showError(_ value: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: "Error", message: value, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
     }
}


extension AddCityViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterList(text: mySearchBar.text ?? "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filterList(text: mySearchBar.text ?? "")
    }
}


extension AddCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.filteredRegisters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: RegisterCityCell.identifier) as? RegisterCityCell {
            
            let register = viewModel.model.filteredRegisters[indexPath.row]
            
            let city_name = register.city_name ?? ""
            let country_name = register.country_name ?? ""
            
            
            cell.titleLabel.text = city_name + ", " + String(country_name)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

extension AddCityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectedCity?(viewModel.model.filteredRegisters[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}
