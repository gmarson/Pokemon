//
//  UIAlertControllerExtension.swift
//  Pokemon
//
//  Created by Gabriel Marson on 05/04/19.
//  Copyright © 2019 Gabriel Marson. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func errorAlert(message: String) -> UIAlertController {
        let a = UIAlertController(title: "Oops", message: message, preferredStyle: UIAlertController.Style.alert)
        
        a.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        
        return a
    }
}
