//
//  DetailReducer.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 10/08/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

func detailReducer(action: Action, state: DetailState?) -> DetailState {
    
    print("Detail reducer called")
    let unwrappedState = state ?? DetailState.idle
    return unwrappedState
}
