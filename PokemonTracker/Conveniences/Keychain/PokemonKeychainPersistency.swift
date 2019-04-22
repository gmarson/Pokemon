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
}

class PokemonKeychainPersistency {
    
    let keychain = KeychainSwift()
    private var savedPokemons = [String]()
    private let key = "key"
    
    init() {
        savedPokemons = UserDefaults.standard.stringArray(forKey: key) ?? [String]()
    }
    
    func isInDatabase(key: String) -> Bool {
        return savedPokemons.first { (name) -> Bool in
            return key == name
        } != nil
    }
    
    func save(pokemon: Pokemon, onSuccess: (() -> ())? = nil, onFailure: (() -> ())? = nil) {
        if let encoded = try? JSONEncoder().encode(pokemon) {
            keychain.set(encoded, forKey: pokemon.prettyName)
            savedPokemons.append(pokemon.prettyName)
            UserDefaults.standard.set(savedPokemons, forKey: key)
            onSuccess?()
        } else {
            onFailure?()
            print("Encode Failed")
        }
    }
    
    func retrieve(key: String, onSuccess: ((Pokemon) -> ()), onFailure: (() -> ())? = nil) {
        
        guard let data = keychain.getData(key) else {
            onFailure?()
            return
        }
    
        if let decoded = try? JSONDecoder().decode(Pokemon.self, from: data) {
            onSuccess(decoded)
        } else {
            print("Decode Failed")
            onFailure?()
        }
    }
    
    func retrieveAll() -> [Pokemon] {
        var pokemons = [Pokemon]()
        savedPokemons.forEach { (name) in
            retrieve(key: name, onSuccess: { (pokemon) in
                pokemons.append(pokemon)
            })
        }
        
        return pokemons
    }
    
    func remove(key: String, onSuccess: (() -> ()), onFailure: ((KeychainErrors) -> ())? = nil) {
        if keychain.delete(key) {
            
            self.savedPokemons.removeAll { (name) -> Bool in
                return name == key
            }
            
            UserDefaults.standard.set(self.savedPokemons, forKey: self.key)
            onSuccess()
        } else {
            onFailure?(KeychainErrors.deletion)
        }
    }
    
    func deleteDatabase() {
        savedPokemons = [String]()
        UserDefaults.standard.set(savedPokemons, forKey: self.key)
        keychain.clear()
    }
}
