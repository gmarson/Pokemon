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

public typealias Headers = [String:String]

protocol NetworkDispatcherProtocol {
    var baseUrl: URL? { get }
    init(path: String)
    func request<T: Codable>(of Type: T.Type, method: HTTPMethod, headers: Headers, payload: Data?, onSuccess: ((NetworkResponse ,T) -> ()), onFailure: ((NetworkError) -> ()), onCompletion: (() -> ()))
    func request<T: Codable>(of Type: T.Type, method: HTTPMethod, headers: Headers, payload: Data?, onSuccess: ((NetworkResponse ,[T]) -> ()), onFailure: ((NetworkError) -> ()), onCompletion: (() -> ()))
    func request(method: HTTPMethod, headers: Headers, payload: Data?, onSuccess: ((NetworkResponse) -> ()), onFailure: ((NetworkError) -> ()), onCompletion: (() -> ()))
}

class NetworkDispatcher: NetworkDispatcherProtocol {
    
    // MARK: - Properties
    private(set) var baseUrl: URL?
    private var encoder: EncoderProtocol = Encoder()
    private var decoder: DecoderProtocol = Decoder()
    let session = URLSession.shared
    
    // MARK: - Lifecycle
    required init(path: String) {
        if let url = URL(string: Environment.shared.baseURL + path) {
            self.baseUrl = url
        }
    }
    
    // MARK: - Responses
    func request<T>(of Type: T.Type,
                    method: HTTPMethod,
                    headers: Headers,
                    payload: Data?,
                    onSuccess: ((NetworkResponse, T) -> ()),
                    onFailure: ((NetworkError) -> ()),
                    onCompletion: (() -> ())) where T : Codable
    {
        
        guard let url = self.baseUrl else {
            onFailure(NetworkError(code: .invalidURL, response: nil, request: nil) )
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
        }
        
        task.resume()
    }
    
    func request<T>(of Type: T.Type,
                    method: HTTPMethod,
                    headers: Headers,
                    payload: Data?,
                    onSuccess: ((NetworkResponse, [T]) -> ()),
                    onFailure: ((NetworkError) -> ()),
                    onCompletion: (() -> ())) where T : Codable
    {
        
        guard let url = self.baseUrl else {
            onFailure(NetworkError(code: .invalidURL, response: nil, request: nil) )
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            //encode here
        }
        
        task.resume()
    }
    
    func request(method: HTTPMethod,
                 headers: Headers,
                 payload: Data?,
                 onSuccess: ((NetworkResponse) -> ()),
                 onFailure: ((NetworkError) -> ()),
                 onCompletion: (() -> ()))
    {
        guard let url = self.baseUrl else {
            onFailure(NetworkError(code: .invalidURL, response: nil, request: nil) )
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
           
            
            
        }
        
        task.resume()
    }
    
}
