//
//  SavedPokemonsViewModel.swift
//  Pokemon
//
//  Created by Gabriel Marson on 27/03/19.
//  Copyright © 2019 Gabriel Marson. All rights reserved.
//

import Foundation
import RxSwift

class SavedPokemonsViewModel {
    
    enum ViewState {
        case idle
        case retrieved(pokemons: [Pokemon])
    }
    
    var viewState = BehaviorSubject<ViewState>(value: .idle)
    var pokemons = [Pokemon]()
    
    func retrievePokemons() {
        pokemons = PokemonKeychainPersistency().retrieveAll()
        viewState.onNext(.retrieved(pokemons: pokemons))
    }
    
}
