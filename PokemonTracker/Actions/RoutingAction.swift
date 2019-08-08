//
//  RoutingAction.swift
//  PokemonTracker
//
//  Created by Gabriel M on 7/29/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

protocol RoutingAction: Action {}
struct SearchRouteAction: RoutingAction {}
struct SavedRouteAction: RoutingAction {}

struct DeatailRouteAction: RoutingAction {
    
    private(set) var requestingCoordinator: Coordinator
    
    init(requestingCoordinator: Coordinator) {
        self.requestingCoordinator = requestingCoordinator
    }
}
