//
//  Keychain.swift
//  pokemon-demo
//
//  Created by Gabriel Augusto Marson on 25/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
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
        return savedPokemons.contains { key == $0 }
    }
    
    func save(
        pokemon: Pokemon,
        onSuccess: (() -> Void)? = nil,
        onFailure: (() -> Void)? = nil
    ) {
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
    
    func retrieve(
        key: String,
        onSuccess: ((Pokemon) -> Void),
        onFailure: (() -> Void)? = nil
    ) {
        
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
        savedPokemons.forEach {
            retrieve(key: $0, onSuccess: { pokemon in
                pokemons.append(pokemon)
            })
        }
        
        return pokemons
    }
    
    func remove(
        key: String,
        onSuccess: (() -> Void),
        onFailure: ((KeychainErrors) -> Void)? = nil
    ) {
        if keychain.delete(key) {
            
            self.savedPokemons.removeAll { name -> Bool in
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
