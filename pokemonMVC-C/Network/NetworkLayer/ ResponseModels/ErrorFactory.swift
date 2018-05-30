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
}

class ErrorFactory {
    
    func getError(type: ErrorType) -> NetworkError {
        
        switch type {
        case .serializationError:
            return NetworkError(code: 410, message: type.rawValue)
        case .invalidURL:
            return NetworkError(code: 411, message: type.rawValue)
        case .parametersNil:
            return NetworkError(code: 412, message: type.rawValue)
        }
    }
}
