//
//  Pokemon.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 3/30/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

struct Pokemon : Codable {
    var id: Int?
    var name: String?
    var base_experience: Int?
    var height: Int?
    var is_default: Bool?
    var order: Int?
    var weight: Int?
    var abilities: [Ability]?
}
