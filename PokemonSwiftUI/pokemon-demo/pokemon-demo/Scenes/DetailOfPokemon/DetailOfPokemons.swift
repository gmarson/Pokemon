//
//  DetailOfPokemons.swift
//  pokemon-demo
//
//  Created by Gabriel Augusto Marson on 27/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

typealias DetailKeychainError = DetailViewModel.KeychainErrors
typealias DetailViewState = DetailViewModel.ViewState

class DetailViewModel {
    
    enum ViewState: Equatable {
        static func == (lhs: DetailViewModel.ViewState, rhs: DetailViewModel.ViewState) -> Bool {
            switch (lhs, rhs) {
           
            case (.pokemonReceived, .pokemonReceived):
                return true
            case (.pokemonRemoved, .pokemonRemoved):
                return true
            case (.pokemonAdded, pokemonAdded):
                return true
            case let (.keychainError(error1), .keychainError(error2)):
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
        self.viewState = .pokemonReceived(pokemon: pokemon)
    }
    
    var viewState: ViewState = .idle
    private var pokemon: Pokemon
    private var keychain = PokemonKeychainPersistency()
    
    var isPokemonInDatabase: Bool {
        return PokemonKeychainPersistency().isInDatabase(key: pokemon.prettyName)
    }
    
    func saveToDatabase() {
        keychain.save(
            pokemon: pokemon,
            onSuccess: {
                self.viewState = .pokemonAdded
            }) {
                self.viewState = .keychainError(.failToAdd)
        }
    }
    
    func removeFromDatabase() {
        keychain.remove(
            key: pokemon.prettyName,
            onSuccess: {
                self.viewState = .pokemonRemoved
            }) { _ in
                self.viewState = .keychainError(.failToDelete)
        }
    }
    
    func addOrRemoveFromDatabase() {
        isPokemonInDatabase ? removeFromDatabase() : saveToDatabase()
    }
}
