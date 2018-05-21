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
    var baseUrl: URL? { get }
    init(path: String)
    func request<T: Codable>(of Type: T.Type, method: HTTPMethod, headers: HTTPHeaders, payload: Data?, onSuccess: ((T) -> ()), onFailure: ((NetworkError) -> ()), onCompletion: (() -> ()))
    func request<T: Codable>(of Type: T.Type, method: HTTPMethod, headers: HTTPHeaders, payload: Data?, onSuccess: (([T]) -> ()), onFailure: ((NetworkError) -> ()), onCompletion: (() -> ()))
    func request(method: HTTPMethod, headers: HTTPHeaders, payload: Data?, onSuccess: (() -> ()), onFailure: ((NetworkError) -> ()), onCompletion: (() -> ()))
}

class NetworkDispatcher: NetworkDispatcherProtocol {
    
    // MARK: - Properties
    private(set) var baseUrl: URL?
    
    // MARK: - Lifecycle
    required init(path: String) {
        if let url = URL(string: Environment.shared.baseURL + path) {
            self.baseUrl = url
        }
    }
    
    // MARK: - Responses
    func request<T>(of Type: T.Type, method: HTTPMethod, headers: HTTPHeaders, payload: Data?, onSuccess: ((T) -> ()), onFailure: ((NetworkError) -> ()), onCompletion: (() -> ())) where T : Decodable, T : Encodable {
        
    }
    
    func request<T>(of Type: T.Type, method: HTTPMethod, headers: HTTPHeaders, payload: Data?, onSuccess: (([T]) -> ()), onFailure: ((NetworkError) -> ()), onCompletion: (() -> ())) where T : Decodable, T : Encodable {
        
    }
    
    func request(method: HTTPMethod, headers: HTTPHeaders, payload: Data?, onSuccess: (() -> ()), onFailure: ((NetworkError) -> ()), onCompletion: (() -> ())) {
        
    }
    
    
}
