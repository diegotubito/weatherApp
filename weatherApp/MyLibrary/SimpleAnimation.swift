//
//  SimpleAnimation.swift
//  weatherApp
//
//  Created by Gomez David Diego on 01/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit

extension UIView {
    
    func slide(fromX: CGFloat?, toX: CGFloat, duration: TimeInterval) {
        
        let yPosition = self.frame.origin.y
        
        let height = self.frame.height
        let width = self.layer.frame.size.width
        
        
        if fromX != nil {
            self.frame = CGRect(x: fromX!, y: yPosition, width: width, height: height)
        }
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.frame = CGRect(x: toX, y: yPosition, width: width, height: height)
            
        })
    }
    
    func slide(fromX: CGFloat?, toX: CGFloat, duration: TimeInterval, completion: @escaping () -> Void) {
        
        let yPosition = self.frame.origin.y
        
        let height = self.frame.height
        let width = self.layer.frame.size.width
        
        if fromX != nil {
            self.frame = CGRect(x: fromX!, y: yPosition, width: width, height: height)
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.frame = CGRect(x: toX, y: yPosition, width: width, height: height)
            
        }) { (finished) in
            completion()
        }
    }
}




