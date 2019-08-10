//
//  DetailState.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 10/08/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

enum DetailState: Equatable {
    static func == (lhs: DetailState, rhs: DetailState) -> Bool {
        switch (lhs, rhs) {
            
        case (.pokemonReceived(_), .pokemonReceived(_)):
            return true
        case (.pokemonRemoved, .pokemonRemoved):
            return true
        case (.pokemonAdded, pokemonAdded):
            return true
        case (let .keychainError(error1), let .keychainError(error2)):
            return error1 == error2
        case (.idle, .idle):
            return true
        default:
            return false
        }
    }
    
    case pokemonReceived(pokemon: Pokemon)
    case pokemonRemoved
    case pokemonAdded
    case keychainError(_ type: KeychainErrors)
    case idle
}






