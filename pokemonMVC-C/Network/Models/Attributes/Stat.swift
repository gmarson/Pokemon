//
//  Stats.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 4/7/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

struct Stat: Codable {
    var base_stat: Int?
    var effort: Int?
    var stat: NameAndUrl?
}
