//
//  SavedReducer.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 08/08/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift

func savedReducer(action: Action, state: SavedState?) -> SavedState {
    
    print("Saved reducer called")
    let unwrappedState = state ?? SavedState.idle
    
//    switch action {
//
//    case let finishedSearchAction as FinishedSearchAction:
//        return SearchState.retrieved(pokemon: finishedSearchAction.pokemon!)
//    case let downloadedImage as DownloadedImageAction:
//        return SearchState.downloadedImage(data: downloadedImage.pngData)
//
//    default: break
//        
//    }
    
    return unwrappedState
}
