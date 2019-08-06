//
//  SearchViewModel.swift
//  Pokemon
//
//  Created by Gabriel Marson on 05/04/19.
//  Copyright © 2019 Gabriel Marson. All rights reserved.
//

import ReSwift

protocol PokemonSearchCoordinatorDelegate {
    func toPokemonDetailed(searchDTO: SearchDTO)
}

struct SearchDTO {
    let pokemon: Pokemon
}

class SearchViewModel {
    
    var coordinatorDelegate: PokemonSearchCoordinatorDelegate?
    var pokemon: Pokemon! = nil
    
    var numberOfRowsInSection: Int {
        return pokemon == nil ? 0 : 1
    }
    
}

extension SearchViewModel {
    func toPokemonDetailed(index: Int) {
        guard let pokemon = pokemon else { return }
        let dto = SearchDTO(pokemon: pokemon)
        coordinatorDelegate?.toPokemonDetailed(searchDTO: dto)
    }
}
