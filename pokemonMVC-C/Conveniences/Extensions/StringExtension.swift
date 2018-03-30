//
//  StringExtension.swift
//  WhiteLabel
//
//  Created by João Paulo dos Anjos on 06/11/17.
//  Copyright © 2017 Zup IT. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Localization
  var localize: String {
    return NSLocalizedString(self, comment: "")
  }
  
}

