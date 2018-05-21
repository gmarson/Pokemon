//
//  NetworkResponse.swift
//  pokemonMVC-C
//
//  Created by Zup on 21/05/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

class NetworkResponse {
    var response: URLResponse?
    var request: URLRequest?
    var rawResponseObject: String?
    
    required init(response: URLResponse) {
        self.response = response
    }
    
    
}
