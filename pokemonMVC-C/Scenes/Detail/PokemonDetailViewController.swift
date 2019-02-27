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
    
    @IBOutlet weak var pokemonTitle: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func setupScreen() {
        pokemonTitle.text = pokemon.name
        
    }

}
