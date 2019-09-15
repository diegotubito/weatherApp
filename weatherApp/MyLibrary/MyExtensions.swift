//
//  MyExtensions.swift
//  weatherApp
//
//  Created by Gomez David Diego on 08/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation

extension Date {
    func toString(formato: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formato
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    var nombreDelDia : String {
        let calendar = Calendar.current
        let dia = calendar.component(.weekday, from: self)
        
        let nombre = DIAS[dia-1].localized
        
        return nombre
    }
}


extension String {
    func toDate(formato: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formato
        
        let dateNSDate = dateFormatter.date(from: self)
        
        return dateNSDate
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

}


let DIAS = ["Sunday".localized,
                  "Monday".localized,
                  "Tuesday".localized,
                  "Wednesday".localized,
                  "Thursday".localized,
                  "Friday".localized,
                  "Saturday".localized]
