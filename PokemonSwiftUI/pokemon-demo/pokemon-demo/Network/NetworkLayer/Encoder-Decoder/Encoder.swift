//
//
//  pokemon-demo
//
//  Created by Gabriel Augusto Marson on 25/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
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
