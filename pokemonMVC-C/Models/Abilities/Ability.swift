//
//  Abilities.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 3/30/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

struct Ability : Codable {
    var is_hidden: Bool?
    var slot: Int?
    var name: String?
    var url: URL?
    

    private enum AbilityCodingKeys : String, CodingKey {
        case ability = "ability"
        case is_hidden = "is_hidden"
        case slot = "slot"
        
        enum NestedCodingKeys: String, CodingKey {
            case name
            case url
        }
    }
    
    public init(from decoder:Decoder) throws {
        let abilityContainer = try decoder.container(keyedBy: AbilityCodingKeys.self)
        let nestedContainer = try abilityContainer.nestedContainer(keyedBy: AbilityCodingKeys.NestedCodingKeys.self, forKey: .ability)
        
        self.is_hidden = try abilityContainer.decode(Bool.self, forKey: .is_hidden)
        self.slot = try abilityContainer.decode(Int.self, forKey: .slot)
        self.name = try nestedContainer.decode(String.self, forKey: .name)
        self.url = try nestedContainer.decode(URL.self, forKey: .url)
        
        
    }
    
}
