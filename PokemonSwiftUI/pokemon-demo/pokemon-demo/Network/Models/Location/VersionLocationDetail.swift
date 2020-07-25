//
//  VersionLocationDetail.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 4/7/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

struct VersionLocationDetail: Codable {
    var max_chance: Int?
    var chance: Int?
    var method: NameAndUrl?
    var encounter_details: [EncounterDetail]?
}
