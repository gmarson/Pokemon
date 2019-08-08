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
        return SearchState.retrieved(pokemon: finishedSearchAction.pokemon!)
    case let downloadedImage as DownloadedImageAction:
        return SearchState.downloadedImage(data: downloadedImage.pngData)
        
    default: break
    
    }
    
    return unwrappedState
}
