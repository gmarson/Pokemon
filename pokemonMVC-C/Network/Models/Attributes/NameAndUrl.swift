//
//  NameAndUrl.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 4/7/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

struct NameAndUrl: Codable {
    var name: String?
    var url: URL?
}

extension NameAndUrl {
    var prettyName: String {
        get {
            guard let name = name else { return "" }
            return name.firstUppercased
        }
        set {
            name = newValue
        }
    }
}
