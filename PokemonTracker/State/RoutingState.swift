//
//  RoutingState.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 29/07/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

enum RoutingState: Equatable {
    static func == (lhs: RoutingState, rhs: RoutingState) -> Bool {
        switch (lhs, rhs) {
        case (.search, .search):
            return true
        case (.saved, .saved):
            return true
        case (.detail(_), .detail(_)):
            return false
        default:
            return false
        }
    }
    
    case search
    case saved
    case detail(requestingCoordinator: Coordinator)
}
