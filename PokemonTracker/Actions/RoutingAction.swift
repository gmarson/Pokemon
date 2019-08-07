//
//  RoutingAction.swift
//  PokemonTracker
//
//  Created by Gabriel M on 7/29/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

struct RoutingAction: Action {
    let destination: RoutingDestination
    
    init(destination: RoutingDestination) {
        self.destination = destination
    }
}
