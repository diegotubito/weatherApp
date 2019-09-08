//
//  ServiceProtocol.swift
//  weatherApp
//
//  Created by Gomez David Diego on 01/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation
import UIKit

protocol ServiceManagerProtocol {
    func retrieveData(url: String, result: @escaping(ServiceManager.Weather?, Error?) -> Void)
}

