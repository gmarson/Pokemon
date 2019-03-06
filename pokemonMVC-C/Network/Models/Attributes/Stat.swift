//
//  Stats.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 4/7/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

enum StatColorType: String {
    case attack = "attack"
    case defense = "defense"
    case speed = "speed"
    case hp = "hp"
    case specialDefense = "special-defense"
    case specialAttack = "special-attack"
    case notAvailable = "N/A"
}

struct Stat: Codable {
    var base_stat: Int?
    var effort: Int?
    var stat: NameAndUrl?
}

extension Stat {
    var statType: StatColorType {
        guard let name = stat?.name else { return StatColorType.notAvailable }
        switch name {
        case "attack":
            return StatColorType.attack
        case "defense":
            return StatColorType.defense
        case "hp":
            return StatColorType.hp
        case "speed":
            return StatColorType.speed
        case "special-attack":
            return StatColorType.specialAttack
        case "special-defense":
            return StatColorType.specialDefense
        default:
            return StatColorType.notAvailable
        }
        
    }
}
