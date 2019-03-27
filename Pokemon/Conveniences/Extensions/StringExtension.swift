//
//  StringExtension
//  pokemonMVC-C
//
//  Created by Gabriel M on 3/30/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Localization
    var localize: String {
        return NSLocalizedString(self, comment: "")
    }
    
}

extension StringProtocol {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}
