//
//  SavedPokemonsViewController.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 19/02/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit
import ReSwift

protocol SavedPokemonsViewControllerProtocol: class {
    
}

class SavedPokemonsViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: SavedPokemonsViewModel!
    
    class func newInstance(viewModel: SavedPokemonsViewModel) -> SavedPokemonsViewController {
        let viewController = SavedPokemonsViewController.instantiate(viewControllerOfType: SavedPokemonsViewController.self)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupTableView()
    }
    
    private func setupTitle() {
        title = "Saved"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PokemonTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //TODO need to subscribe first
        
        store.dispatch(GetSavedPokemonsAction())
    }
    
}

extension SavedPokemonsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier) as! PokemonTableViewCell
        let pokemon = viewModel.pokemons[indexPath.row]
        cell.setup(pokemon: pokemon)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.toPokemonDetailed(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            viewModel.removePokemon(index: indexPath.row)
        }
    }
    
}


extension SavedPokemonsViewController: StoreSubscriber {
    
    func newState(state: SavedState) {
        
        print("New state on Saved view Controller")
        switch state {
            
        case .idle:
            break
        case .retrieved(_):
            let decision = self.viewModel.pokemons.count != 0
            self.stackView.isHidden = decision
            self.tableView.isHidden = !decision
            self.tableView.reloadData()
        case .keychainError(_):
            //TODO show alert with error
            break
        }
    }
    
    
}
