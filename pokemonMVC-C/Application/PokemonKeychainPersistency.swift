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
    
    func encode<T: Encodable>(key: String, object: T) {
        if let encoded = try? JSONEncoder().encode(object) {
            keychain.set(encoded, forKey: key)
        } else {
            print("Encode Failed")
        }
    }
    
    func decode<T: Decodable>(key: String, type: T) -> T? {
        guard let data = keychain.getData(key) else { return nil }
        if let decoded = try? PropertyListDecoder().decode(T.self, from: data) {
            return decoded
        }
        
        print("Decode Failed")
        return nil
    }
    
    func delete(key: String) {
        keychain.delete(key)
    }
    
    func deleteDatabase() {
        keychain.clear()
    }
}
