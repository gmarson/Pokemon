//
//  EncounterDetail.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 4/7/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

struct EncounterDetail: Codable {
    var min_level: Int?
    var max_level: Int?
    var condition_values: [NameAndUrl]?
}
