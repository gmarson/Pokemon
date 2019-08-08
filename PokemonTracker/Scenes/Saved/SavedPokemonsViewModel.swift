//
//  SavedPokemonsViewModel.swift
//  Pokemon
//
//  Created by Gabriel Marson on 27/03/19.
//  Copyright © 2019 Gabriel Marson. All rights reserved.
//

import Foundation
import RxSwift

protocol SavedPokemonsCoordinatorDelegate {
    func toPokemonDetailed(savedDTO: SavedDTO)
}

struct SavedDTO {
    let pokemon: Pokemon
}

class SavedPokemonsViewModel {
    
    var coordinatorDelegate: SavedPokemonsCoordinatorDelegate?
    var pokemons = [Pokemon]()
    
    init() {
        retrievePokemons()
    }
    
    
    
    func removePokemon(index: Int) {
        PokemonKeychainPersistency().remove(key: pokemons[index].prettyName, onSuccess: {
            self.retrievePokemons()
        }) { error in
            self.viewState.onNext(.keychainError(error: error))
        }
    }
    
}

extension SavedPokemonsViewModel {
    func toPokemonDetailed(index: Int) {
        let dto = SavedDTO(pokemon: pokemons[index])
        coordinatorDelegate?.toPokemonDetailed(savedDTO: dto)
    }
}
