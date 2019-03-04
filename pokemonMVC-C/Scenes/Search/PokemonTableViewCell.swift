//
//  PokemonTableViewCell.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 11/3/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import UIKit
import Kingfisher

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonTitle: UILabel!
    @IBOutlet weak var pokemonWeight: UILabel!
    @IBOutlet weak var pokemonHeight: UILabel!
    
    @IBOutlet weak var pokemonType1: PokemonTypeView!
    @IBOutlet weak var pokemonType2: PokemonTypeView!
    
    private struct Constants {
        let weight = "Weight: "
        let height = "Height: "
        let types = "Types:"
        let notAvailable = "N/A"
    }
    
    private let constants = Constants()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup(pokemon: Pokemon) {
        pokemonImageView.kf.indicatorType = .activity
        pokemonTitle.text = pokemon.prettyName
        
        if let height = pokemon.height, let weight = pokemon.weight {
            pokemonHeight.text = constants.height + String(height)
            pokemonWeight.text = constants.weight + String(weight)
        }
        
        pokemonType1.setup(types: pokemon.types, position: 0)
        pokemonType2.setup(types: pokemon.types, position: 1)
        
    }
    
    
    
}
