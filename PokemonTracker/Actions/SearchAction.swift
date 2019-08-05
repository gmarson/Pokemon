//
//  SearchAction.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 05/08/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import Foundation
import ReSwift

func searchPokemon(state: AppState, store: Store<AppState>) -> SearchAction {
    
    PokemonServices().getPokemon(identifier: state.searchState.pokemonToBeSearched, onSuccess: { (response, pokemon) in
        guard let pokemon = pokemon else {
            //self.viewState.onNext(.error(SearchState.Errors.emptyPokemon))
            return
        }
        
        //self.pokemon = pokemon
        //self.viewState.onNext(.retrieved(pokemon: pokemon)) show also update current state
        
        
        //self.downloadImage() should dispatch an action to download image
        
    }, onFailure: { (response) in
        //self.viewState.onNext(.error(Errors.emptyPokemon))
    })
    
    return SearchAction()
}

struct SearchAction: Action {
    
}


