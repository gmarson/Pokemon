//
//  Environment.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 3/30/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import UIKit

class Environment {
    
    // MARK: - Singleton
    static let shared = Environment()
    
    // MARK: - Properties
    var baseURL: String! {
        return "https://pokeapi.co/api/v2/"
    }
}
