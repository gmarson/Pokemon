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
    @IBOutlet weak var pokemonTypes: UILabel!
    @IBOutlet weak var type1View: UIView!
    @IBOutlet weak var type2View: UIView!
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    
    private struct Constants {
        let weight = "Weight: "
        let height = "Height: "
        let types = "Types:"
        let notAvailable = "N/A"
    }
    
    private let constants = Constants()
    
    func setup(pokemon: Pokemon) {
        pokemonImageView.kf.setImage(with: pokemon.sprites?.front_default)
        pokemonTitle.text = pokemon.name?.firstUppercased
        
        if let height = pokemon.height, let weight = pokemon.weight {
            pokemonHeight.text = constants.height + String(height)
            pokemonWeight.text = constants.weight + String(weight)
        }
        
        guard let firstType = pokemon.types?.first else { return }
        
        type1View.backgroundColor = associatedColor(typeName: firstType.type?.name)
        type1Label.text = firstType.type?.name?.firstUppercased
        
        if let size = pokemon.types?.count, size > 1, let secondType = pokemon.types?[1] {
            type2View.isHidden = false
            type2View.backgroundColor = associatedColor(typeName: secondType.type?.name)
            type2Label.text = secondType.type?.name?.firstUppercased
        }
    }
    
    private func associatedColor(typeName: String?) -> UIColor? {
        guard let name = typeName?.lowercased() else { return UIColor.white }
        let color = UIColor(named: name)
        return color
    }
    
}
