//
//  ChosenCityCell.swift
//  weatherApp
//
//  Created by Gomez David Diego on 08/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit

class CityListCell: UITableViewCell {
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var temperatureInfoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        selectionStyle = .none
    }
    
    static var identifier : String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
