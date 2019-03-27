//
//  Encoder.swift
//  pokemonMVC-C
//
//  Created by Zup on 21/05/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation


protocol EncoderProtocol {
    func encode<T: Encodable>(object: T) -> Data?
}

class Encoder: EncoderProtocol {
    
    func encode<T: Encodable>(object: T) -> Data? {
       
        let encodedData = try? JSONEncoder().encode(object)
        return encodedData
    }
}
