//
//  PokemonKeychainButton.swift
//  pokemon
//
//  Created by Gabriel M on 3/3/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit

class PokemonKeychainButton: UIButton {

    enum PokemonButtonType {
        case add
        case remove
        case idle
    }
    
    var pokemonButtonType = PokemonButtonType.idle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }

    private func style() {
        layer.cornerRadius = 5.0
    }
    
    func turnIntoDeleteButton() {
        backgroundColor = UIColor(named: "Remove")
        setTitle("Remove", for: .normal)
        pokemonButtonType = .remove
    }
    
    func turnIntoAddButton() {
        backgroundColor = UIColor(named: "Add")
        setTitle("Add", for: .normal)
        pokemonButtonType = .add
    }
    
}
