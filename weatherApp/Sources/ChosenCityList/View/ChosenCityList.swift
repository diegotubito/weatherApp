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
  
    @IBOutlet weak var tableView : UITableView!
    
    var viewModel : ChosenCityListViewModelContract!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        //Loader init, used when loading from the internet.
        loaderInitialization()
        
        //add Refresh Control to Table View
        addRefresh()
        
        //register cells
        registerCells()
        
        //button item for adding new city
        addPlusButton()
        
        //load persisted cities
        viewModel.loadStoreCities()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        navigationItem.title = "Your Cities"
    }
    
    private func addRefresh() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        
        viewModel.resetCityTemp()
        
        viewModel.loadStoreCities()
        self.refreshControl.endRefreshing()
        
    }
    
    private func registerCells() {
        tableView.register(ChosenCityCell.nib, forCellReuseIdentifier: ChosenCityCell.identifier)
    }
    
    private func loaderInitialization() {
        //Just change bar colors to blue
        DDBarLoader.color = .blue
        DDBarLoader.barWidth = 10
        DDBarLoader.numberOfBars = 3
        DDBarLoader.backgroundAlpha = 1
        DDBarLoader.roundedCap = true
    }
    
    private func addPlusButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonHandler))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func addButtonHandler() {
        performSegue(withIdentifier: "segue_to_add_city", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super .prepare(for: segue, sender: sender)
        
        if let controller = segue.destination as? DetailViewController {
            controller.viewModel = DetailViewModel(withView: controller, service: ServiceManager())
            if let register = sender as? City {
                controller.viewModel.setSelectedRegister(register)
            }
        }
        
        if let controller = segue.destination as? AddCityViewController {
            controller.viewModel = AddCityViewModel(withView: controller)
            controller.onSelectedCity = { selectedNewCity in
                self.viewModel.addNewCity(selectedNewCity)

            }
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
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: "Error", message: errorMessage, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func reloadList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension ChosenCityListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ChosenCityCell.identifier) as? ChosenCityCell {
            
            let register = viewModel.model.cities[indexPath.row]
            let name : String? = register.city_name
            let temp : Double? = register.temp
            
            cell.titleLabel.text = name
            
            if let currentTemp = temp {
                cell.temperatureLabel.text = String(currentTemp.rounded()) + "ºC"
                cell.activity.stopAnimating()
            } else {
                cell.temperatureLabel.text = ""
                cell.activity.startAnimating()
            }
            
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.model.cities.remove(at: indexPath.row)
            PersistedDataManager.saveCities(cities: self.viewModel.model.cities)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


extension ChosenCityListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue_to_detail", sender: viewModel.model.cities[indexPath.row])
        
    }
  
}
