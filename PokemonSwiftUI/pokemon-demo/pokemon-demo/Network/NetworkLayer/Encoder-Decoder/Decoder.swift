//
//
//  pokemon-demo
//
//  Created by Gabriel Augusto Marson on 25/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
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
