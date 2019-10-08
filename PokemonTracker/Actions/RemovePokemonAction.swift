//
//  RemovePokemonAction.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 08/08/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift
import ReSwiftThunk

struct RemovedPokemonAction: Action {
    private(set) var error: KeychainErrors?
    private(set) var pokemons: [Pokemon]?
    
    init(pokemons: [Pokemon]) {
        self.error = nil
        self.pokemons = pokemons
    }
    
    init(error: KeychainErrors) {
        self.pokemons = nil
        self.error = error
    }
}

func removePokemonThunk(prettyName: String?) -> Thunk<AppState> {
    return Thunk<AppState> { dispatch, getState in
        
        print("Remove Pokemon Thunk")
        
        if let prettyName = prettyName {
            PokemonKeychainPersistency().remove(key: prettyName, onSuccess: { remainingPokemons in
                dispatch(RemovedPokemonAction(pokemons: remainingPokemons))
            }) { error in
                dispatch(RemovedPokemonAction(error: error))
            }
        } else {
            dispatch(RemovedPokemonAction.init(error: .deletion))
        }
        
    }
}



