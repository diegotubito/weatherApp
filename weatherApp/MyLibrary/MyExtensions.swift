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

let MESES = [1:"Enero".localized, 2:"Febrero".localized, 3:"Marzo".localized, 4:"Abril".localized, 5:"Mayo".localized, 6:"Junio".localized, 7:"Julio".localized, 8:"Agosto".localized, 9:"Septiembre".localized, 10:"Octubre".localized, 11:"Noviembre".localized, 12:"Diciembre".localized]
