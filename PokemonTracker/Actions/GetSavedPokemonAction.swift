//
//  SavedAction.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 08/08/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

struct GetSavedPokemonsAction: Action {
    var retrievedPokemons: [Pokemon]
    
    init() {
        retrievedPokemons = PokemonKeychainPersistency().retrieveAll()
    }
}
