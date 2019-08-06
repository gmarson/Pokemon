//
//  SearchState.swift
//  PokemonTracker
//
//  Created by Gabriel M on 7/29/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

struct SearchState: StateType {

    init(currentViewState: ViewState? = nil) {
        if let state = currentViewState {
            self.currentViewState = state
        } else {
            self.currentViewState = .idle
        }
    }
    
    private(set) var currentViewState: ViewState
    
    enum ViewState {
        case idle
        case retrieved(pokemon: Pokemon)
        case downloadedImage(data: Data?)
        case error(_ error: Errors)
    }
    
    enum Errors: String {
        case emptyPokemon = "Pokemon not Found"
        case networkError = "Something went wrong"
    }
    
}
