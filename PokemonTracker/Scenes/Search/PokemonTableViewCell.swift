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
    @IBOutlet private weak var pokemonTitle: UILabel!
    @IBOutlet private weak var pokemonWeight: UILabel!
    @IBOutlet private weak var pokemonHeight: UILabel!
    
    @IBOutlet private weak var pokemonType1: PokemonTypeView!
    @IBOutlet private weak var pokemonType2: PokemonTypeView!
    
    private struct Constants {
        let weight = "Weight: "
        let height = "Height: "
        let types = "Types:"
        let notAvailable = "N/A"
    }
    
    private let constants = Constants()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImageView.image = UIImage()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        pokemonImageView.kf.indicatorType = .activity
    }
    
    func setup(pokemon: Pokemon) {
        
        if let png = pokemon.pngImage {
            pokemonImageView.image = UIImage(data: png)
        }
        
        pokemonTitle.text = pokemon.prettyName
        
        if let height = pokemon.height, let weight = pokemon.weight {
            pokemonHeight.text = constants.height + String(height)
            pokemonWeight.text = constants.weight + String(weight)
        }
        
        pokemonType1.setup(types: pokemon.types, position: 0)
        pokemonType2.setup(types: pokemon.types, position: 1)
        
    }
    
    
    
}
