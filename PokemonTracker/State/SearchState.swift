//
//  SearchState.swift
//  PokemonTracker
//
//  Created by Gabriel M on 7/29/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

struct SearchState: StateType {
    
    init(pokemonToBeSearched: String = "", currentViewState: ViewState? = nil) {
        self.pokemonToBeSearched = pokemonToBeSearched
        if let state = currentViewState {
            self.currentViewState = state
        } else {
            self.currentViewState = .idle
        }
    }
    
    var pokemonToBeSearched: String
    private(set) var currentViewState: ViewState
    
    enum ViewState {
        case idle
        case retrieved(pokemon: Pokemon)
        case downloadedImage
        case error(_ error: Errors)
    }
    
    enum Errors: String {
        case emptyPokemon = "Pokemon not Found"
        case networkError = "Something went wrong"
    }
    
}
