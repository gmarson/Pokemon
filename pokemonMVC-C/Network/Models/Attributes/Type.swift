//
//  Type.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 4/7/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation
import UIKit

struct Type: Codable {
    var slot: Int?
    var type: NameAndUrl?
    
    lazy var associatedColor: UIColor? = {
        guard let typeName = self.type?.name else { return UIColor.white }
        return UIColor(named: typeName)
    }()
}
