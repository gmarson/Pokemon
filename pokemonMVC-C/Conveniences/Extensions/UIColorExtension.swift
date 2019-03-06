//
//  UIColorExtension.swift
//  pokemon
//
//  Created by Gabriel M on 3/5/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit

extension UIColor {
    class func associatedColor(typeName: String?) -> UIColor? {
        guard let name = typeName?.lowercased() else { return UIColor.clear }
        let color = UIColor(named: name)
        return color
    }
}
