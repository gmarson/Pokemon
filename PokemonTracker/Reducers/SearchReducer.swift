//
//  SearchReducer.swift
//  PokemonTracker
//
//  Created by Gabriel M on 7/29/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

func searchReducer(action: Action, state: SearchState?) -> SearchState {
    
    print("Search reducer called")
    let unwrappedState = state ?? SearchState.idle
    
    switch action {
        
    case let finishedSearchAction as FinishedSearchAction:
        guard let pokemon = finishedSearchAction.pokemon else { return unwrappedState }
        return SearchState.retrieved(pokemon: pokemon)
    case let downloadedImage as DownloadedImageAction:
        return SearchState.downloadedImage(data: downloadedImage.pngData)
    default:
        return unwrappedState
    }
}
