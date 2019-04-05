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
    
    enum ViewState {
        case idle
        case retrieved(pokemons: [Pokemon])
        case keychainError(error: KeychainErrors)
    }
    
    var coordinatorDelegate: SavedPokemonsCoordinatorDelegate?
    var viewState = BehaviorSubject<ViewState>(value: .idle)
    var pokemons = [Pokemon]()
    
    init() {
        retrievePokemons()
    }
    
    func retrievePokemons() {
        pokemons = PokemonKeychainPersistency().retrieveAll()
        viewState.onNext(.retrieved(pokemons: pokemons))
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
