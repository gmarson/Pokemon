//
//  Pokemon.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 3/30/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable {
    var id: Int?
    private var name: String?
    private var base_experience: Int?
    var height: Int?
    var is_default: Bool?
    var order: Int?
    var weight: Int?
    var sprites: Sprites?
    var species: NameAndUrl?
    var game_indices: [GameIndice]?
    var stats: [Stat]?
    var abilities: [Ability]?
    var forms: [NameAndUrl]?
    var types: [Type]?
    var moves: [Move]?
    var held_itens: [HeldItem]?
    var location_area_encounters: URL?
    
    
    var pngImage: Data?
}

extension Pokemon {
    
    var prettyName: String {
        get {
            guard let name = name else { return "" }
            return name.firstUppercased
        }
        set {
            name = newValue
        }
    }
    
    var baseExperience: String {
        get {
            guard let be = base_experience else { return "N/A" }
            return String(be)
        }
    }
    
    var commomAbility: Ability? {
        get {
            return abilities?.filter({ (ability) -> Bool in
                return ability.is_hidden == false
            }).first
        }
    }
}
