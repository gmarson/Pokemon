//
//  PokemonPersistency.swift
//  pokemon
//
//  Created by Gabriel M on 2/28/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import Foundation
import KeychainSwift

class PokemonKeychainPersistency {
    
    let keychain = KeychainSwift()
    
    func isInDatabase(key: String) -> Bool {
        var pokemon: Pokemon? = nil
        retrieve(key: key, onSuccess: { pkm in
            pokemon = pkm
        })
        
        return pokemon != nil
    }
    
    func save(pokemon: Pokemon, onSuccess: (() -> ())? = nil, onFailure: (() -> ())? = nil) {
        if let encoded = try? JSONEncoder().encode(pokemon) {
            keychain.set(encoded, forKey: pokemon.prettyName)
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
    
    func remove(key: String, onSuccess: (() -> ()), onFailure: (() -> ())? = nil) {
        if keychain.delete(key) {
            onSuccess()
        } else {
            onFailure?()
        }
    }
    
    func deleteDatabase() {
        keychain.clear()
    }
}
