//
//  Decoder.swift
//  pokemonMVC-C
//
//  Created by Zup on 21/05/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation

protocol DecoderProtocol {
    func decode<T: Decodable>(response: Data?, type: T.Type) -> T?
}

class Decoder: DecoderProtocol {
    
    func decode<T: Decodable>(response: Data?, type: T.Type) -> T? {
        
        if let data = response {
            let decodedData = try? JSONDecoder().decode(T.self, from: data)
            return decodedData
        }
        return nil
    }
    
    
    
}
