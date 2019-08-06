//
//  SearchReducer.swift
//  PokemonTracker
//
//  Created by Gabriel M on 7/29/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

func searchReducer(action: Action, state: SearchState?) -> SearchState {
    
    var unwrappedState = state ?? SearchState()
    
    switch action {
        
    case let finishedSearchAction as FinishedSearchAction:
        return SearchState(currentViewState: SearchState.ViewState.retrieved(pokemon: finishedSearchAction.pokemon!))
    
    default: break
    
    }
    
    
    return unwrappedState
}
