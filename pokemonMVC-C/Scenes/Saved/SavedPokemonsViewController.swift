//
//  SavedPokemonsViewController.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 19/02/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit

protocol SavedPokemonsCoordinatorDelegate {
    func toPokemonDetailed(savedDTO: SavedDTO)
}

struct SavedDTO {
    let pokemon: Pokemon
}

class SavedPokemonsViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    private var pokemons = [Pokemon]()
    var coordinatorDelegate: SavedPokemonsCoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupTableView()
    }
    
    private func setupTitle() {
        title = "Saved"
    }
    
    private func retrivePokemons() {
        pokemons = PokemonKeychainPersistency().retrieveAll()
        let decision = pokemons.count != 0
        stackView.isHidden = decision
        tableView.isHidden = !decision
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PokemonTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrivePokemons()
    }
    
}

extension SavedPokemonsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier) as! PokemonTableViewCell
        let pokemon = pokemons[indexPath.row]
        
        cell.setup(pokemon: pokemon)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinatorDelegate?.toPokemonDetailed(savedDTO: SavedDTO(pokemon: pokemons[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            PokemonKeychainPersistency().remove(key: pokemons[indexPath.row].prettyName, onSuccess: {
                self.retrivePokemons()
            }) {
                //Show alert message error
            }
        }
    }
    
}
