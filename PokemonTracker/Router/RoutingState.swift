//
//  RoutingState.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 29/07/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

struct RoutingState: StateType {
    var navigationState: RoutingDestination
    
    init(navigationState: RoutingDestination = .search) {
        self.navigationState = navigationState
    }
}
