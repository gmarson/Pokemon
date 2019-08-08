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

struct AppState: StateType {
    let routingState: RoutingState
    let searchState: SearchState
    let savedState: SavedState
}
