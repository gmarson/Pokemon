//
//  DetailViewModel.swift
//  Pokemon
//
//  Created by Gabriel Marson on 05/04/19.
//  Copyright © 2019 Gabriel Marson. All rights reserved.
//

import Foundation
import RxSwift

typealias DetailKeychainError = DetailViewModel.KeychainErrors
typealias DetailViewState = DetailViewModel.ViewState

class DetailViewModel {
    
    enum ViewState: Equatable {
        static func == (lhs: DetailViewModel.ViewState, rhs: DetailViewModel.ViewState) -> Bool {
            switch (lhs, rhs) {
           
            case (.pokemonReceived(_) , .pokemonReceived(_)):
                return true
            case (.pokemonRemoved, .pokemonRemoved):
                return true
            case (.pokemonAdded, pokemonAdded):
                return true
            case (let .keychainError(error1), let .keychainError(error2)):
                return error1 == error2
            case (.idle, .idle):
                return true
            default:
                return false
            }
        }
        
        case pokemonReceived(pokemon: Pokemon)
        case pokemonRemoved
        case pokemonAdded
        case keychainError(_ type: KeychainErrors)
        case idle
    }
    
    enum KeychainErrors: Equatable {
        case failToDelete
        case failToAdd
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
    
    func saveToDatabase() {
        PokemonKeychainPersistency().save(pokemon: pokemon, onSuccess: {
             self.viewState.onNext(.pokemonAdded)
        }) {
            self.viewState.onNext(.keychainError(.failToAdd))
        }
    }
    
    func removeFromDatabase() {
        PokemonKeychainPersistency().remove(key: pokemon.prettyName, onSuccess: {
            self.viewState.onNext(.pokemonRemoved)
        }) { _ in
            self.viewState.onNext(.keychainError(.failToDelete))
        }
    }
    
    func addOrRemoveFromDatabase() {
        isPokemonInDatabase ? removeFromDatabase() : saveToDatabase()
    }
}


extension DetailViewModel {
    
}
