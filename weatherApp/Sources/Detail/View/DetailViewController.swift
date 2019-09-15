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
    @IBOutlet weak var selectedCity: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var viewModel : DetailViewModelContract!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        registerCells()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)

        navigationItem.title = "Extended Forecast"
        selectedCity.text = viewModel.model.selectedRegister.city_name ?? ""
        
        viewModel.loadExtended(days: EXTENDED_DAYS)
    }
    
    func registerCells() {
        tableView.register(ExtendedCell.nib, forCellReuseIdentifier: ExtendedCell.identifier)
    }
    
}


extension DetailViewController: DetailViewContract {
    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                
                self.navigationController?.popViewController(animated: true)
                
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func showSuccess() {
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
}


extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.registers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ExtendedCell.identifier) as? ExtendedCell {
            
            let register = self.viewModel.model.registers[indexPath.row]
            cell.descriptionLabel.text = (register.weather.description ?? "None")
            cell.minTempLabel.text = String(Int(register.min_temp?.rounded() ?? 0.0))
            cell.maxTempLabel.text = String(Int(register.max_temp?.rounded() ?? 0.0))
            cell.icon.image = UIImage(named: register.weather.icon ?? "")
            cell.dateLabel.text = register.datetime?.toDate(formato: "yyyy-MM-dd")?.nombreDelDia
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
