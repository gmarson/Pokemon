//
//  RoutingReducer.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 29/07/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

func routingReducer(action: Action, state: RoutingState?) -> RoutingState {
    print("Routing Reducer called")
    
    var strongState = state ?? RoutingState()
    
    if let routingAction = action as? RoutingAction {
        strongState.navigationState = routingAction.destination
    }
    
    return strongState
}

