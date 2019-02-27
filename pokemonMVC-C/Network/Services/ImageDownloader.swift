//
//  ImageDownloader.swift
//  pokemonMVC-C
//
//  Created by Zup on 27/02/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import Foundation

class ImageDownloader {
    private let dispatcher: NetworkDispatcher
    
    init(url: URL) {
        dispatcher = NetworkDispatcher(url: url)
    }
    
    func downloadImage() {
        
    }
    
    
}
