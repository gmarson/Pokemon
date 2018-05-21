//
//  NetworkDispatcher.swift
//  pokemonMVC-C
//
//  Created by Zup on 16/05/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public typealias HTTPHeaders = [String:String]

protocol NetworkDispatcherProtocol {
    var baseUrl: URL { get }
    init(baseUrl: URL)
    func request<T: Codable>(of Type: T.Type, method: HTTPMethod, headers: HTTPHeaders, onSuccess success: ((T) -> ()), onFailure failure: (() -> ()), onCompletion completion: (() -> ()))
    
}

class NetworkDispatcher  {
    
    // MARK: - Properties
    
    private(set) var baseUrl: URL
    
    // MARK: - Lifecycle
    
    required init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    // MARK: - Responses
    
    
    
    
    
}
