//
//  PokemonDetailViewController.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 19/02/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet var statViews: [PokemonStatInfoView]!
    @IBOutlet private weak var pokemonTitle: UILabel!
    @IBOutlet private weak var pokemonImage: UIImageView!
    @IBOutlet private weak var baseExperienceLabel: UILabel!
    @IBOutlet private weak var abilityLabel: UILabel!
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var pokemonKeychainButton: PokemonKeychainButton!
    @IBOutlet weak var pokemonType1: PokemonTypeView!
    @IBOutlet weak var pokemonType2: PokemonTypeView!
    
    var pokemon: Pokemon = Pokemon()
  
    private struct Constants {
        let baseExperience = "Base Experience: "
        let species = "Species: "
        let ability = "Ability: "
    }
    
    var isPokemonInDatabase: Bool {
        return PokemonKeychainPersistency().isInDatabase(key: pokemon.prettyName)
    }
    
    private let constants = Constants()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setButtonStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        setTitle()
    }
    
    private func setTitle() {
        title = "Details"
    }
    
    private func setButtonStatus() {
        isPokemonInDatabase ? pokemonKeychainButton.turnIntoDeleteButton() : pokemonKeychainButton.turnIntoAddButton()
    }
    
    private func setupScreen() {
        pokemonTitle.text = pokemon.prettyName
        if let data = pokemon.pngImage {
            pokemonImage.image = UIImage(data: data)
        }
    
        baseExperienceLabel.text = constants.baseExperience + pokemon.baseExperience
        if let species = pokemon.species {
            speciesLabel.text = constants.species + species.prettyName
        }
        
        if let a = pokemon.commomAbility, let abilityName = a.ability?.prettyName {
            abilityLabel.text = constants.ability + abilityName
        }
        
        pokemonType1.setup(types: pokemon.types, position: 0)
        pokemonType2.setup(types: pokemon.types, position: 1)
        setupStatViews()
    }
    
    private func setupStatViews() {
        guard let stats = pokemon.stats, stats.count == statViews.count else { return }
        
        zip(statViews, stats).forEach { tuple in
            tuple.0.setup(tuple.1)
        }
    }

    @IBAction func addOrRemove(_ sender: PokemonKeychainButton) {
        isPokemonInDatabase ? removeFromDatabase() : saveToDatabase()
    }
    
    private func saveToDatabase() {
        PokemonKeychainPersistency().save(pokemon: pokemon, onSuccess: {
            self.setButtonStatus()
        })
    }
    
    private func removeFromDatabase() {
        PokemonKeychainPersistency().remove(key: pokemon.prettyName, onSuccess: {
            self.setButtonStatus()
        }) { _ in
            // TODO : show alert with failure
        }
    }
    
}
