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
    var errorFactory: ErrorFactory { get set }
    func request<T: Codable>(of Type: T.Type, method: HTTPMethod, headers: Headers, payload: Data?, onSuccess: @escaping ((NetworkResponse, T?) -> ()), onFailure: @escaping ((NetworkResponse) -> ()), onCompletion: (() -> ()))
    func request<T: Codable>(of Type: T.Type, method: HTTPMethod, headers: Headers, payload: Data?, onSuccess: @escaping ((NetworkResponse, [T]?) -> ()), onFailure: @escaping ((NetworkResponse) -> ()), onCompletion: (() -> ()))
    func request(method: HTTPMethod, headers: Headers, payload: Data?, onSuccess: @escaping ((NetworkResponse) -> ()),  onFailure: @escaping ((NetworkResponse) -> ()), onCompletion: (() -> ()))
}

class NetworkDispatcher: NetworkDispatcherProtocol {
    
    // MARK: - Properties
    private(set) var baseUrl: URL?
    private var encoder: EncoderProtocol = Encoder()
    private var decoder: DecoderProtocol = Decoder()
    let session = URLSession.shared
    internal var errorFactory = ErrorFactory()
    
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
                    onSuccess: @escaping ((NetworkResponse, T?) -> ()),
                    onFailure: @escaping ((NetworkResponse) -> ()),
                    onCompletion: (() -> ())) where T : Codable
    {
        
        let networkResponse = NetworkResponse()
        guard let url = self.baseUrl else {
            networkResponse.error = self.errorFactory.getError(type: .serializationError)
            onFailure(networkResponse)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let data = data {
                networkResponse.rawResponseObject = String(data: data, encoding: .utf8)
            }
        }
        
        task.resume()
    }
    
    
    func request<T>(of Type: T.Type,
                    method: HTTPMethod,
                    headers: Headers,
                    payload: Data?,
                    onSuccess: @escaping ((NetworkResponse, [T]?) -> ()),
                    onFailure: @escaping ((NetworkResponse) -> ()),
                    onCompletion: (() -> ())) where T : Codable
    {
        let networkResponse = NetworkResponse()
        guard let url = self.baseUrl else {
            networkResponse.error = self.errorFactory.getError(type: .serializationError)
            onFailure(networkResponse)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let decodedObject = self.decoder.decodeArray(data: data, type: T.self) else {
                networkResponse.error = self.errorFactory.getError(type: .serializationError)
                onFailure(networkResponse)
                return
            }
            
            if let data = data {
                networkResponse.rawResponseObject = String(data: data, encoding: .utf8)
            }
            
            if let error = error {
                networkResponse.error = NetworkError(message: "", error: error)
                onFailure(networkResponse)
            }
            
            onSuccess(networkResponse, decodedObject)
        }
        
        task.resume()
    }
    
    func request(method: HTTPMethod,
                 headers: Headers,
                 payload: Data?,
                 onSuccess: @escaping ((NetworkResponse) -> ()),
                 onFailure: @escaping ((NetworkResponse) -> ()),
                 onCompletion: (() -> ()))
    {
        let networkResponse = NetworkResponse()
        guard let url = self.baseUrl else {
            networkResponse.error = self.errorFactory.getError(type: .serializationError)
            onFailure(networkResponse)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let response = response {
                networkResponse.response = response
            }
    
            if let data = data {
                networkResponse.rawResponseObject = String(data: data, encoding: .utf8)
                onSuccess(networkResponse)
            }
            
            if let error = error {
                networkResponse.error = NetworkError(message: "", error: error)
                onFailure(networkResponse)
            }
            
        }
        
        task.resume()
    }
    
}
