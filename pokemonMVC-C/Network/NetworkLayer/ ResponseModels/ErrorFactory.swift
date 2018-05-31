//
//  ErrorFactory.swift
//  pokemonMVC-C
//
//  Created by Zup on 25/05/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

public enum ErrorType : String {
    case serializationError = "Serialization Error"
    case invalidURL = "Invalid URL"
    case parametersNil = "Parameters are null"
    case other = ""
}

class ErrorFactory {
    
    func getError(type: ErrorType, error: Error? = nil) -> NetworkError {
        
        switch type {
        case .serializationError:
            return NetworkError(message: type.rawValue, error: error)
        case .invalidURL:
            return NetworkError(message: type.rawValue)
        case .parametersNil:
            return NetworkError(message: type.rawValue)
        case .other:
            return NetworkError(error: error)
        }
    }
}
