//
//  DownloadImageAction.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 05/08/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import Kingfisher
import ReSwift
import ReSwiftThunk

let downloadPokemonImageThunk = Thunk<AppState> { dispatch, getState in
    guard let state = getState() else { return }
    
    switch state.searchState {
    case .retrieved(let pokemon):
        
        guard let url = pokemon.sprites?.front_default else { return }
        KingfisherManager.shared.retrieveImage(with: url) { (result : Result) in
            switch result {
                
            case .success(let success):
                DispatchQueue.main.async {
                    dispatch(DownloadedImageAction(data: success.image.pngData()))
                }
                
            case .failure(_):
                break
            }
        }
    
    default:
        break
    }
}

struct DownloadedImageAction: Action {
    let pngData: Data?
    
    init(data: Data?) {
        self.pngData = data
    }
}
