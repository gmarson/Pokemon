//
//  PokemonPersistency.swift
//  pokemon
//
//  Created by Gabriel M on 2/28/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import Foundation
import KeychainSwift

enum KeychainErrors: String {
    case deletion = "We are having trouble to remove this pokemon, try again later!"
    case save = "We are having trouble to save this pokemon, try again later!"
    case fetch = "We are having trouble fetch pokemons, try again later!"
    case unknown = "Something went wrong. Try again later!"
}

class PokemonKeychainPersistency {
    
    let keychain = KeychainSwift()
    private var savedPokemons = [String]()
    private let key = "key"
    
    init() {
        savedPokemons = UserDefaults.standard.stringArray(forKey: key) ?? [String]()
    }
    
    /// Check if a pokemon is stored locally
    ///
    /// - Parameter key: name of pokemon
    /// - Returns: Boolean indicating wheter pokemons is or not in database
    func isInDatabase(key: String) -> Bool {
        return savedPokemons.first { (name) -> Bool in
            return key == name
        } != nil
    }
    
    /// Save pokemon locally
    ///
    /// - Parameters:
    ///   - pokemon: Pokemon object to be saved
    ///   - onSuccess: onSuccess block confirming save
    ///   - onFailure: onFailure block confirming an error
    func save(pokemon: Pokemon, onSuccess: (() -> ())? = nil, onFailure: ((KeychainErrors) -> ())? = nil) {
        if let encoded = try? JSONEncoder().encode(pokemon) {
            keychain.set(encoded, forKey: pokemon.prettyName)
            savedPokemons.append(pokemon.prettyName)
            UserDefaults.standard.set(savedPokemons, forKey: key)
            onSuccess?()
        } else {
            onFailure?(.save)
            print("Encode Failed")
        }
    }
    
    /// Retrieve one pokemon
    ///
    /// - Parameters:
    ///   - key: desired pokemon name
    ///   - onSuccess: onSuccess block returning the pokemon
    ///   - onFailure: onFailure block returning an error
    func retrieve(key: String, onSuccess: ((Pokemon) -> ()), onFailure: ((KeychainErrors) -> ())? = nil) {
        
        guard let data = keychain.getData(key) else {
            onFailure?(.unknown)
            return
        }
    
        if let decoded = try? JSONDecoder().decode(Pokemon.self, from: data) {
            onSuccess(decoded)
        } else {
            print("Decode Failed")
            onFailure?(.fetch)
        }
    }
    
    /// Retrieve all pokemons stored in keychain
    ///
    /// - Returns: all pokemons stored in keychain
    func retrieveAll() -> [Pokemon] {
        var pokemons = [Pokemon]()
        savedPokemons.forEach { (name) in
            retrieve(key: name, onSuccess: { (pokemon) in
                pokemons.append(pokemon)
            })
        }
        
        return pokemons
    }
    
    /// Remove a certain pokemon from keychain
    ///
    /// - Parameters:
    ///   - key: Desired pokemon name
    ///   - onSuccess: onSuccess block returning remaining pokemons
    ///   - onFailure: onFailure block returning an error
    func remove(key: String, onSuccess: (([Pokemon]) -> ()), onFailure: ((KeychainErrors) -> ())? = nil) {
        if keychain.delete(key) {
            
            self.savedPokemons.removeAll { (name) -> Bool in
                return name == key
            }
            
            UserDefaults.standard.set(self.savedPokemons, forKey: self.key)
            onSuccess(retrieveAll())
        } else {
            onFailure?(KeychainErrors.deletion)
        }
    }
    
    /// Delete all pokemons stored locally. Use with caution!
    func deleteDatabase() {
        savedPokemons = [String]()
        UserDefaults.standard.set(savedPokemons, forKey: self.key)
        keychain.clear()
    }
}
