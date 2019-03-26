//
//  SavedPokemonsViewController.swift
//  pokemonMVC-C
//
//  Created by Zup on 19/02/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit

class SavedPokemonsViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    private let keychain = PokemonKeychainPersistency()
    private var pokemons = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupTableView()
    }
    
    private func setupTitle() {
        title = "Saved"
    }
    
    private func retrivePokemons() {
        pokemons = keychain.retrieveAll()
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
    
}
