//
//  DetailViewModel.swift
//  Pokemon
//
//  Created by Gabriel Marson on 05/04/19.
//  Copyright © 2019 Gabriel Marson. All rights reserved.
//

import Foundation
import RxSwift

class DetailViewModel {
    
    struct Constants {
        let baseExperience = "Base Experience: "
        let species = "Species: "
        let ability = "Ability: "
        let failToAdd = "This pokemon could not be added"
        let failToRemove = "This pokemon could not be removed"
        let title = "Details"
    }
    
    init(pokemon: Pokemon?) {
        self.pokemon = pokemon
        //self.viewState.onNext(.pokemonReceived(pokemon: pokemon))
        self.constants = Constants()
    }
    
    private(set) var constants: Constants
    private(set) var pokemon: Pokemon?
    
    var isPokemonInDatabase: Bool {
        guard let key = pokemon?.prettyName else { return false }
        return PokemonKeychainPersistency().isInDatabase(key: key)
    }
    
    func saveToDatabase() {
    }
    
    func removeFromDatabase() {
//        PokemonKeychainPersistency().remove(key: pokemon.prettyName, onSuccess: { _ in
//            self.viewState.onNext(.pokemonRemoved)
//        }) { _ in
//            self.viewState.onNext(.keychainError(.failToDelete))
//        }
    }
    
}


extension DetailViewModel {
    
}
