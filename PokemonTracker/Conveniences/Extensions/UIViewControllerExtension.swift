//
//  UIViewControllerExtension.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 3/30/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func instantiate<T: UIViewController>(viewControllerOfType type: T.Type, storyboardName: String, bundle: Bundle? = nil) -> T {
        
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: "\(type)") as! T
    }
    
    class func instantiate<T: UIViewController>(viewControllerOfType type: T.Type, nibName: String? = nil, bundle: Bundle? = nil) -> T {
        
        if let name = nibName {
            return T(nibName: name, bundle: bundle)
        } else {
            return T(nibName: "\(type)", bundle: bundle)
        }
        
    }
    
}
