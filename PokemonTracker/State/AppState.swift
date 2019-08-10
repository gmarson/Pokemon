//
//  AppState.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 29/07/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift
import ReSwiftThunk

let thunkMiddleware: Middleware<AppState> = createThunksMiddleware()

var store = Store<AppState>(reducer: appReducer, state: nil, middleware: [thunkMiddleware])

//enum AppState: StateType, Equatable {
//    case routingState(reducer: RoutingState)
//    case searchState(reducer: SearchState)
//    case savedState(reducer: SavedState)
//    case all(routingReducer: RoutingState, searchReducer: SearchState, savedReducer: SavedState)
//}

struct AppState: StateType, Equatable {
    let routingState: RoutingState
    let searchState: SearchState
    let savedState: SavedState
    let detailState: DetailState
}
