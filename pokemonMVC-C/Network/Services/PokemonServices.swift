//
//  PokemonServices.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 3/30/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation


class PokemonServices {
    
    private let baseUrl = "pokemon/"
    
    func getPokemon(identifier : String,
                    onSuccess: @escaping ((NetworkResponse, Pokemon?) -> ()),
                    onFailure: @escaping ((NetworkResponse) -> ()),
                    onCompletion: (() -> ())) {
        
        let dispatcher = NetworkDispatcher(baseUrl: baseUrl + identifier)
        dispatcher.request(type: Pokemon.self, method: .get, onSuccess: { (response, pokemon) in
            onSuccess(response, pokemon)
        }, onFailure: { (response) in
            onFailure(response)
        }, onCompletion: {
            onCompletion()
        })
    }
    
}
