//
//  SearchAction.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 05/08/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift
import ReSwiftThunk


func fetchPokemonThunk(pokemonName: String) -> Thunk<AppState> {
    return Thunk<AppState> { dispatch, getState in
        //guard let state = getState() else { return }
        print("Fetch Pokemon Thunk")
        PokemonServices().getPokemon(identifier: pokemonName, onSuccess: { (response, pokemon) in
            DispatchQueue.main.async {
                dispatch(FinishedSearchAction(pokemon: pokemon, networkResponse: response))
            }
        }, onFailure: { (response) in
            DispatchQueue.main.async {
                dispatch(FinishedSearchAction(networkResponse: response))
            }
        })
    }
}


struct FinishedSearchAction: Action {
    let pokemon: Pokemon?
    let networkResponse: NetworkResponse
    
    init(pokemon: Pokemon? = nil, networkResponse: NetworkResponse) {
        self.pokemon = pokemon
        self.networkResponse = networkResponse
    }
}

