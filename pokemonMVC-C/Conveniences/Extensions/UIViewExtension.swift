//
//  UIViewExtension.swift
//  pokemon
//
//  Created by Gabriel M on 3/4/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit

extension UIView {
    
     func loadViewFromNib(nibName: String) -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
