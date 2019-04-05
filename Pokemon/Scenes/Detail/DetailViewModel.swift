//
//  DetailViewModel.swift
//  Pokemon
//
//  Created by Gabriel Marson on 05/04/19.
//  Copyright © 2019 Gabriel Marson. All rights reserved.
//

import Foundation
import RxSwift


class DetailViewModel {
    
    enum ViewState {
        case pokemonReceived(pokemon: Pokemon)
        case keychainOperationMade
        case keychainError
        case idle
    }
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.viewState.onNext(.pokemonReceived(pokemon: pokemon))
    }
    
    var viewState = BehaviorSubject<ViewState>(value: .idle)
    private var pokemon: Pokemon!
    
    var isPokemonInDatabase: Bool {
        return PokemonKeychainPersistency().isInDatabase(key: pokemon.prettyName)
    }
    
    private func saveToDatabase() {
        PokemonKeychainPersistency().save(pokemon: pokemon, onSuccess: {
            self.viewState.onNext(.keychainOperationMade)
        })
    }
    
    private func removeFromDatabase() {
        PokemonKeychainPersistency().remove(key: pokemon.prettyName, onSuccess: {
            self.viewState.onNext(.keychainOperationMade)
        }) { _ in
            self.viewState.onNext(.keychainError)
        }
    }
    
    func addOrRemoveFromDatabase() {
        isPokemonInDatabase ? removeFromDatabase() : saveToDatabase()
    }
}


extension DetailViewModel {
    
}
