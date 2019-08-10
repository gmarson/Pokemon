//
//  SearchState.swift
//  PokemonTracker
//
//  Created by Gabriel M on 7/29/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import Foundation

enum SearchState: Equatable {
    
    enum Errors: String {
        case emptyPokemon = "Pokemon not Found"
        case networkError = "Something went wrong"
    }
    
    static func == (lhs: SearchState, rhs: SearchState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.retrieved(let lhs) , .retrieved(let rhs)):
            return lhs.id == rhs.id
        case (.downloadedImage(let lhs), .downloadedImage(let rhs)):
            return lhs == rhs
        case (.error(let lhs), .error(let rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
    
    case idle
    case retrieved(pokemon: Pokemon)
    case downloadedImage(data: Data?)
    case error(_ error: Errors)
}










