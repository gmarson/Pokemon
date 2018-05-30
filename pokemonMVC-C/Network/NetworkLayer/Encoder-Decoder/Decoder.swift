//
//  Decoder.swift
//  pokemonMVC-C
//
//  Created by Zup on 21/05/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

protocol DecoderProtocol {
    func decode<T: Decodable>(data: Data?, type: T.Type) -> T?
    func decodeArray<T: Decodable>(data: Data?, type: T.Type) -> [T]?
}

class Decoder: DecoderProtocol {
    
    func decode<T: Decodable>(data: Data?, type: T.Type) -> T? {
        
        if let data = data {
            let decodedData = try? JSONDecoder().decode(T.self, from: data)
            return decodedData
        }
        return nil
    }
    
    func decodeArray<T: Decodable>(data: Data?, type: T.Type) -> [T]? {
        
        if let data = data {
            let decodedData = try? JSONDecoder().decode([T].self, from: data)
            return decodedData
        }
        return nil
    }
    
}
