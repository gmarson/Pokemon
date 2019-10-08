//
//  AppState.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 29/07/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift
import ReSwiftThunk

let thunkMiddleware: Middleware<AppState> = createThunkMiddleware()

var store = Store<AppState>(reducer: appReducer, state: nil, middleware: [thunkMiddleware])

struct AppState: StateType, Equatable {
    let routingState: RoutingState
    let searchState: SearchState
    let savedState: SavedState
    let detailState: DetailState
}
