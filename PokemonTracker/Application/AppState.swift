//
//  AppState.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 29/07/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

struct AppState: StateType {
    let routingState: RoutingState
    let searchState: SearchState
}
