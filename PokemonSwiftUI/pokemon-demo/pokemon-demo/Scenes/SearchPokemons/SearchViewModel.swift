//
//  SearchViewModel.swift
//  pokemon-demo
//
//  Created by Gabriel Augusto Marson on 27/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

protocol PokemonSearchCoordinatorDelegate: AnyObject {
    func toPokemonDetailed(searchDTO: SearchDTO)
}

struct SearchDTO {
    let pokemon: Pokemon
}

class SearchViewModel {
    
    enum ViewState {
        case idle
        case retrieved(pokemon: Pokemon)
        case downloadedImage
        case error(_ error: Errors)
    }
    
    enum Errors: String {
        case emptyPokemon = "Pokemon not Found"
        case networkError = "Something went wrong"
    }
    
    weak var coordinatorDelegate: PokemonSearchCoordinatorDelegate?
    var viewState: ViewState = .idle
    var pokemon: Pokemon?
    private let pokemonServices = PokemonServices()
    
    var numberOfRowsInSection: Int {
        return pokemon == nil ? 0 : 1
    }
    
    func searchPokemon(text: String?) {
        
        guard let searchText = text else { return }
        
        pokemonServices.getPokemon(
            identifier: searchText,
            onSuccess: { _, pokemon in
                guard let pokemon = pokemon else {
                    self.viewState = .error(Errors.emptyPokemon)
                    return
                }
                self.pokemon = pokemon
                self.viewState = .retrieved(pokemon: pokemon)
                self.downloadImage()
            
            }, onFailure: { _ in
                self.viewState = .error(Errors.emptyPokemon)
            })
    }
    
    func downloadImage() {
        
//        guard let url = pokemon?.sprites?.front_default else { return }
//
//        KingfisherManager.shared.retrieveImage(with: url) { (result : Result) in
//            switch result {
//
//            case .success(let success):
//                self.viewState.onNext(.downloadedImage)
//                self.pokemon?.pngImage = success.image.pngData()
//            case .failure(_):
//                break
//            }
//        }
    }
    
}

extension SearchViewModel {
    func toPokemonDetailed(index: Int) {
        guard let pokemon = pokemon else { return }
        let dto = SearchDTO(pokemon: pokemon)
        coordinatorDelegate?.toPokemonDetailed(searchDTO: dto)
    }
}
