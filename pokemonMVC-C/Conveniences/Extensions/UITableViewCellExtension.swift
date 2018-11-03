//
//  UITableViewCellExtension.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 3/30/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import UIKit

extension UITableViewCell {
  
  static var identifier: String {
    return String(describing: self)
  }

}
