//
//  NetworkError.swift
//  pokemonMVC-C
//
//  Created by Zup on 21/05/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

struct NetworkError {
    var code: Int?
    var message: String?
    var error: Error?
    
    init(code: Int? = nil, message: String, error: Error? = nil) {
        if let error = error {
            self.error = error
        }
        self.message = message
        //what to do with message and code attributes
    }
}
