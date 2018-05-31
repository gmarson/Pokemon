//
//  NetworkError.swift
//  pokemonMVC-C
//
//  Created by Zup on 21/05/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

struct NetworkError {
    var message: String?
    var error: Error?
    
    init(message: String? = nil, error: Error? = nil) {
        if let error = error {
            self.error = error
            self.message = (message == nil) ? error.localizedDescription : message
        }
    }
}
