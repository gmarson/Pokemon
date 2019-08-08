//
//  SavedReducer.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 08/08/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

func savedReducer(action: Action, state: SavedState?) -> SavedState {
    
    print("Saved reducer called")
    let unwrappedState = state ?? SavedState.idle
    
    switch action {
        
    case let finishedFetchPokemons as GetSavedPokemonsAction:
        return SavedState.retrieved(pokemons: finishedFetchPokemons.retrievedPokemons)
    case let finishedRemovingPokemon as RemovedPokemonAction:
        if let remaining = finishedRemovingPokemon.pokemons {
            return SavedState.retrieved(pokemons: remaining)
            
        } else if let error = finishedRemovingPokemon.error {
            return SavedState.keychainError(error: error)
        }
    default:
        return SavedState.keychainError(error: .unknown)
    }
    
    return unwrappedState
}

