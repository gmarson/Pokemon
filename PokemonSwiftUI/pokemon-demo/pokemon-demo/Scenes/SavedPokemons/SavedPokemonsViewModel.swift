//
//  SavedPokemonsViewModel.swift
//  pokemon-demo
//
//  Created by Gabriel Augusto Marson on 27/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

protocol SavedPokemonState: AnyObject {
    func onChange(_ state: SavedPokemonsViewModel.ViewState)
}

protocol SavedPokemonsCoordinatorDelegate: AnyObject {
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
    
    weak var coordinatorDelegate: SavedPokemonsCoordinatorDelegate?
    weak var stateDelegate: SavedPokemonState?
    
    var viewState: ViewState = .idle {
        didSet {
            stateDelegate?.onChange(viewState)
        }
    }
    var pokemons = [Pokemon]()
    
    init() {
        retrievePokemons()
    }
    
    func retrievePokemons() {
        pokemons = PokemonKeychainPersistency().retrieveAll()
        viewState = .retrieved(pokemons: pokemons)
    }
    
    func removePokemon(index: Int) {
        PokemonKeychainPersistency().remove(
            key: pokemons[index].prettyName,
            onSuccess: {
                self.retrievePokemons()
            }) { [weak self] error in
            self?.viewState = .keychainError(error: error)
        }
    }
    
}

//extension SavedPokemonsViewController: SavedPokemonState {
//    func onChange(_ state: ViewState) {
//
//
//    }
//}

extension SavedPokemonsViewModel {
    func toPokemonDetailed(index: Int) {
        let dto = SavedDTO(pokemon: pokemons[index])
        coordinatorDelegate?.toPokemonDetailed(savedDTO: dto)
    }
}
