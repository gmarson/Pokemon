//
//  PokemonDetailViewController.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 19/02/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon = Pokemon()
    var currentPokemonImage: UIImage?
    let keychain = PokemonKeychainPersistency()
    
    private struct Constants {
        let baseExperience = "Base Experience: "
        let species = "Species: "
        let ability = "Ability: "
    }
    
    var isPokemonInDatabase: Bool {
        return keychain.isInDatabase(key: pokemon.prettyName)
    }
    
    private let constants = Constants()
    
    @IBOutlet private weak var pokemonTitle: UILabel!
    @IBOutlet private weak var pokemonImage: UIImageView!
    @IBOutlet private weak var baseExperienceLabel: UILabel!
    @IBOutlet private weak var type1View: UIView!
    @IBOutlet private weak var type1Label: UILabel!
    @IBOutlet private weak var type2View: UIView!
    @IBOutlet private weak var type2Label: UILabel!
    @IBOutlet private weak var abilityLabel: UILabel!
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var pokemonKeychainButton: PokemonKeychainButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        setButtonStatus()
    }
    
    private func setButtonStatus() {
        isPokemonInDatabase ? pokemonKeychainButton.turnIntoDeleteButton() : pokemonKeychainButton.turnIntoAddButton()
    }
    
    private func setupScreen() {
        pokemonTitle.text = pokemon.prettyName
        pokemonImage.image = currentPokemonImage
        baseExperienceLabel.text = constants.baseExperience + pokemon.baseExperience
        abilityLabel.text = constants.ability
        if let species = pokemon.species {
            speciesLabel.text = constants.species + species.prettyName
        }
        
        if let a = pokemon.commomAbility {
            abilityLabel.text = a.ability?.prettyName
        }
        
        
    }

    @IBAction func addOrRemove(_ sender: PokemonKeychainButton) {
        isPokemonInDatabase ? removeFromDatabase() : saveToDatabase()
    }
    
    private func saveToDatabase() {
        keychain.save(pokemon: pokemon, onSuccess: {
            self.setButtonStatus()
        })
    }
    
    private func removeFromDatabase() {
        keychain.remove(key: pokemon.prettyName, onSuccess: {
            self.setButtonStatus()
        }) {
            // TODO : show alert with failure
        }
    }
    
}
