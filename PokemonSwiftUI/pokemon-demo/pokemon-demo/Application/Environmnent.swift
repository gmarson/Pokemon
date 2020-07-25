//
//  Environmnent.swift
//  pokemon-demo
//
//  Created by Gabriel Augusto Marson on 25/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

struct Environment {
    
    // MARK: - Singleton
    static let shared = Environment()
    
    // MARK: - Properties
    var baseURL: String {
        return "https://pokeapi.co/api/v2/"
    }
}
