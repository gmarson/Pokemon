//
//  Move.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 4/7/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

struct Move: Codable {
    var move: NameAndUrl?
    var version_group_details: [VersionGroupDetail]?
    var move_learn_method: NameAndUrl?
}
