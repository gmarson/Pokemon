//
//  SearchViewModel.swift
//  Pokemon
//
//  Created by Gabriel Marson on 05/04/19.
//  Copyright © 2019 Gabriel Marson. All rights reserved.
//

import ReSwift

struct SearchDTO {
    let pokemon: Pokemon?
}

class SearchViewModel {
    
    var pokemon: Pokemon? = nil
    
    var numberOfRowsInSection: Int {
        return pokemon == nil ? 0 : 1
    }
    
}
