//
//  SearchAction.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 05/08/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

func searchPokemon(state: AppState, store: Store<AppState>) -> SearchAction {
    
    PokemonServices().getPokemon(identifier: state.searchState.pokemonToBeSearched, onSuccess: { (response, pokemon) in
        //self.pokemon = pokemon
        
        //self.viewState.onNext(.retrieved(pokemon: pokemon)) should also update current state
        
        store.dispatch(FinishedSearchAction(pokemon: pokemon))
        store.dispatch(downloadImage(state: state, store: store))
        //self.downloadImage() should dispatch an action to download image
        
    }, onFailure: { (response) in
        store.dispatch(FinishedSearchAction())
        //self.viewState.onNext(.error(Errors.emptyPokemon))
    })
    
    return SearchAction()
}

struct SearchAction: Action {
    
}

struct FinishedSearchAction: Action {
    let pokemon: Pokemon?
    
    init(pokemon: Pokemon? = nil) {
        self.pokemon = pokemon
    }
}

