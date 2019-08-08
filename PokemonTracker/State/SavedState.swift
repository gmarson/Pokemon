//
//  SavedState.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 08/08/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import Foundation


enum SavedState: Equatable {
    static func == (lhs: SavedState, rhs: SavedState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.retrieved(pokemons: let pokemonsLhs), .retrieved(pokemons: let pokemonsRhs)):
            return checkForUniquePokemonInArrays(lhs: pokemonsLhs, rhs: pokemonsRhs)
        case (.keychainError(let lhsError), .keychainError(let rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
    
    private static func checkForUniquePokemonInArrays(lhs: [Pokemon], rhs: [Pokemon]) -> Bool{
        let potentialDiferentPokmeon = lhs.first { (lhsPokemon) -> Bool in
            var isUniquePokemon = true
            
            rhs.forEach({ (rhsPokemon) in
                if rhsPokemon.id == lhsPokemon.id {
                    isUniquePokemon = false
                }
            })
    
            return isUniquePokemon
        }
        return potentialDiferentPokmeon == nil
    }
    
    case idle
    case retrieved(pokemons: [Pokemon])
    case keychainError(error: KeychainErrors)
}
