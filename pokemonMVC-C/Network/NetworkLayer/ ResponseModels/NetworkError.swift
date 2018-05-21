//
//  NetworkError.swift
//  pokemonMVC-C
//
//  Created by Zup on 21/05/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

enum ErrorCode : String {
    case serializationError = "Serialization Error"
    case invalidURL = "Invalid URL"
    case parametersNil = "Parameters are null"
}

struct NetworkError: Error {
    
    var code: ErrorCode
    var response: HTTPURLResponse?
    var request: URLRequest?
}
