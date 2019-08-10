//
//  AppReducer.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 29/07/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    print("App reducer called")
    
//    switch state {
//
//    case .none:
//        return AppState.all(routingReducer: routingReducer(action: action, state: nil), searchReducer: searchReducer(action: action, state: nil), savedReducer: savedReducer(action: action, state: nil))
//    case .some(let strongState):
//        switch strongState {
//
//        case .routingState(let reducer):
//            return AppState.routingState(reducer: reducer)
//        case .searchState(let reducer):
//            return AppState.searchState(reducer: reducer)
//        case .savedState(let reducer):
//            return AppState.savedState(reducer: reducer)
//        case .all(let routingReducer, let searchReducer, let savedReducer):
//            return AppState.all(routingReducer: routingReducer, searchReducer: searchReducer, savedReducer: savedReducer)
//
//        }
//
//    }
    
    return AppState(routingState: routingReducer(action: action, state: state?.routingState),
                    searchState: searchReducer(action: action, state: state?.searchState),
                    savedState: savedReducer(action: action, state: state?.savedState),
                    detailState: detailReducer(action: action, state: state?.detailState))
}
