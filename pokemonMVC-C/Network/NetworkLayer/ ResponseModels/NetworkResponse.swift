//
//  NetworkResponse.swift
//  pokemonMVC-C
//
//  Created by Zup on 21/05/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

class NetworkResponse {
    var response: HTTPURLResponse?
    var request: URLRequest?
    var rawResponseObject: String?
    var error: NetworkError?
    
}
