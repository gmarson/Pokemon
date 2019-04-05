//
//  SearchViewModel.swift
//  Pokemon
//
//  Created by Gabriel Marson on 05/04/19.
//  Copyright © 2019 Gabriel Marson. All rights reserved.
//

import Foundation
import RxSwift
import Kingfisher

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
    
    var coordinatorDelegate: PokemonSearchCoordinatorDelegate?
    var viewState = BehaviorSubject<ViewState>(value: .idle)
    var pokemon: Pokemon! = nil
    private let pokemonServices = PokemonServices()
    
    
    var numberOfRowsInSection: Int {
        return pokemon == nil ? 0 : 1
    }
    
    func searchPokemon(text: String?) {
        
        guard let searchText = text else { return }
        
        pokemonServices.getPokemon(identifier: searchText, onSuccess: { (response, pokemon) in
            guard let pokemon = pokemon else {
                self.viewState.onNext(.error(Errors.emptyPokemon))
                return
            }
            
            self.pokemon = pokemon
            self.viewState.onNext(.retrieved(pokemon: pokemon))
            self.downloadImage()
            
        }, onFailure: { (response) in
            self.viewState.onNext(.error(Errors.emptyPokemon))
        })
    }
    
    func downloadImage() {
        
        guard let url = pokemon?.sprites?.front_default else { return }
        
        KingfisherManager.shared.retrieveImage(with: url) { (result : Result) in
            switch result {
                
            case .success(let success):
                self.viewState.onNext(.downloadedImage)
                self.pokemon?.pngImage = success.image.pngData()
            case .failure(_):
                break
            }
        }
        
       
    }
    
}

extension SearchViewModel {
    func toPokemonDetailed(index: Int) {
        guard let pokemon = pokemon else { return }
        let dto = SearchDTO(pokemon: pokemon)
        coordinatorDelegate?.toPokemonDetailed(searchDTO: dto)
    }
}
