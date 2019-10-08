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
    
    let unwrappedState = state ?? RoutingState.search
    
    switch action {
    case _ as SearchRouteAction:
        return RoutingState.search
    case _ as SavedRouteAction:
        return RoutingState.saved
    case let detail as DeatailRouteAction:
        return RoutingState.detail(requestingCoordinator: detail.requestingCoordinator)
    default:
        return unwrappedState
    }
    
}

