//
//  DownloadImageAction.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 05/08/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import Kingfisher
import ReSwift

func downloadImage(state: AppState, store: Store<AppState>) -> DownloadImageAction {
    
    guard let url = state.searchState.pokemon?.sprites?.front_default else { return DownloadImageAction() }
    
    KingfisherManager.shared.retrieveImage(with: url) { (result : Result) in
        switch result {
            
        case .success(let success):
            store.dispatch(DownloadedImageAction(data: success.image.pngData()))
            
            //TODO need to figure out a way to pass pokemon to the next screen
            //self.viewState.onNext(.downloadedImage)
            //self.pokemon?.pngImage = success.image.pngData()
        case .failure(_):
            break
        }
    }
    
    return DownloadImageAction()
    
}

struct DownloadImageAction: Action {

}

struct DownloadedImageAction: Action {
    let pngData: Data?
    
    init(data: Data?) {
        self.pngData = data
    }
}
