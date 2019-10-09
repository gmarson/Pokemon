//
//  JSONParser.swift
//  PokemonTrackerTests
//
//  Created by Gabriel Marson on 09/10/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import Foundation

class JsonParser {
    func parseToData(fileName:String) -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: fileName, ofType: "json") else { return Data() }
        return try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
    }
    
    func parseToType<T: Decodable>(fileName:String, type: T.Type) -> T {
        let data = parseToData(fileName: fileName)
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
