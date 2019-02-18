//
//  NetworkDispatcher.swift
//  pokemonMVC-C
//
//  Created by Gabriel Marson on 16/05/18.
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
    var baseUrl: URL { get }
    init(baseUrl: String)
    var errorFactory: ErrorFactory { get set }
    func request<T: Decodable>(type: T.Type, method: HTTPMethod, headers: Headers?, payload: Data?, onSuccess: @escaping ((NetworkResponse, T?) -> ()), onFailure: @escaping ((NetworkResponse) -> ()), onCompletion: (() -> ())?)
    func requestArray<T: Decodable>(type: T.Type, method: HTTPMethod, headers: Headers?, payload: Data?, onSuccess: @escaping ((NetworkResponse, [T]?) -> ()), onFailure: @escaping ((NetworkResponse) -> ()), onCompletion: (() -> ())?)
    func request(method: HTTPMethod, headers: Headers?, payload: Data?, onSuccess: @escaping ((NetworkResponse) -> ()),  onFailure: @escaping ((NetworkResponse) -> ()), onCompletion: (() -> ())?)
}

class NetworkDispatcher: NetworkDispatcherProtocol {
    
    // MARK: - Properties
    private(set) var baseUrl: URL
    private var encoder: EncoderProtocol = Encoder()
    private var decoder: DecoderProtocol = Decoder()
    private let session = URLSession.shared
    internal var errorFactory = ErrorFactory()
    private var defaultHeaders = ["Content-Type":"application/json"]
    
    // MARK: - Lifecycle
    required init(baseUrl: String) {
        self.baseUrl = URL(string:Environment.shared.baseURL + baseUrl)!
    }
    
    // MARK: - Responses
    func request<T>(type: T.Type,
                    method: HTTPMethod,
                    headers: Headers? = nil,
                    payload: Data? = nil,
                    onSuccess: @escaping ((NetworkResponse, T?) -> ()),
                    onFailure: @escaping ((NetworkResponse) -> ()),
                    onCompletion: (() -> ())?) where T : Decodable
    {
        
        let networkResponse = NetworkResponse()
       
        guard let urlRequest = self.buildRequest(url: self.baseUrl, httpMethod: method, httpBody: payload, headers: headers) else {
            networkResponse.error = self.errorFactory.getError(type: .invalidURL)
            onFailure(networkResponse)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            networkResponse.request = urlRequest
            networkResponse.response = response as? HTTPURLResponse
            
            if let data = data {
                networkResponse.rawResponseObject = String(data: data, encoding: .utf8)
            }
            
            if let error = error {
                networkResponse.error = self.errorFactory.getError(type: .other, error: error)
                onFailure(networkResponse)
                return
            }
            
            guard let decodedObject = self.decoder.decode(data: data, type: T.self) else {
                networkResponse.error = self.errorFactory.getError(type: .serializationError)
                onFailure(networkResponse)
                return
            }
            
            onSuccess(networkResponse, decodedObject)
        }
        
        task.resume()
    }
    
    func requestArray<T>(type: T.Type,
                    method: HTTPMethod,
                    headers: Headers? = nil,
                    payload: Data? = nil,
                    onSuccess: @escaping ((NetworkResponse, [T]?) -> ()),
                    onFailure: @escaping ((NetworkResponse) -> ()),
                    onCompletion: (() -> ())?) where T : Decodable
    {
        let networkResponse = NetworkResponse()
        guard let urlRequest = self.buildRequest(url: self.baseUrl, httpMethod: method, httpBody: payload, headers: headers) else {
            networkResponse.error = self.errorFactory.getError(type: .invalidURL)
            onFailure(networkResponse)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            networkResponse.request = urlRequest
            networkResponse.response = response as? HTTPURLResponse
            
            if let data = data {
                networkResponse.rawResponseObject = String(data: data, encoding: .utf8)
            }
            
            if let error = error {
                networkResponse.error = self.errorFactory.getError(type: .other, error: error)
                onFailure(networkResponse)
                return
            }
            
            guard let decodedObject = self.decoder.decodeArray(data: data, type: T.self) else {
                networkResponse.error = self.errorFactory.getError(type: .serializationError)
                onFailure(networkResponse)
                return
            }
            
            
            onSuccess(networkResponse, decodedObject)
        }
        
        task.resume()
    }
    
    func request(method: HTTPMethod,
                 headers: Headers? = nil,
                 payload: Data? = nil,
                 onSuccess: @escaping ((NetworkResponse) -> ()),
                 onFailure: @escaping ((NetworkResponse) -> ()),
                 onCompletion: (() -> ())?)
    {
        let networkResponse = NetworkResponse()
        guard let urlRequest = self.buildRequest(url: self.baseUrl, httpMethod: method, httpBody: payload, headers: headers) else {
            networkResponse.error = self.errorFactory.getError(type: .invalidURL)
            onFailure(networkResponse)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            networkResponse.request = urlRequest
            networkResponse.response = response as? HTTPURLResponse
            
            if let error = error {
                networkResponse.error = self.errorFactory.getError(type: .other, error: error)
                onFailure(networkResponse)
                return
            }
            
            if let data = data {
                networkResponse.rawResponseObject = String(data: data, encoding: .utf8)
                onSuccess(networkResponse)
                return
            }
            
        }
        
        task.resume()
    }
    
    private func buildRequest(url: URL, httpMethod: HTTPMethod , httpBody: Data? = nil, headers: Headers? = nil) -> URLRequest? {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = httpBody
        urlRequest.allHTTPHeaderFields = self.defaultHeaders
        urlRequest.httpMethod = httpMethod.rawValue
        
        if let headers = headers {
            for header in headers {
                urlRequest.setValue(header.key, forHTTPHeaderField: header.value)
            }
        }
        
        return urlRequest
    }
    
    func prettyPrinted<T: Codable>(type: T.Type, value: Data?) -> String? {
        
        guard let value = value else { return nil }
        
        do {
            let jsonData = try JSONEncoder().encode(value)
            let jsonString = String(data: jsonData, encoding: .utf8)
            
            return jsonString
        } catch  {
            debugPrint("Error while trying to pretty print")
        }
        
       return nil
        
    }
    
    
}
