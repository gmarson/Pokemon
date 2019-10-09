//
//  SavePokemonAction.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 10/08/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftThunk

struct SavedPokemonAction: Action {
    private(set) var error: KeychainErrors?
    
    init(error: KeychainErrors? = nil) {
        self.error = error
    }
}

func savePokemonThunk(pokemon: Pokemon?) -> Thunk<AppState> {
    return Thunk<AppState> { dispatch, getState in
        print("Save Pokemon Thunk")
        if let pokemon = pokemon {
            PokemonKeychainPersistency().save(pokemon: pokemon, onSuccess: {
                dispatch(SavedPokemonAction())
            }) { error in
                dispatch(SavedPokemonAction(error: error))
            }
        } else {
            dispatch(SavedPokemonAction.init(error: .unknown))
        }
    }
}
