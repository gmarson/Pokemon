//
//  SavedPokemonsViewController.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 19/02/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit
import RxSwift

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
    
    private var viewModel: SavedPokemonsViewModel!
    private let disposeBag = DisposeBag()
    var coordinatorDelegate: SavedPokemonsCoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupTitle()
        setupTableView()
    }
    
    private func setupTitle() {
        title = "Saved"
    }
    
    func bind() {
        
        viewModel.viewState.subscribe { [weak self] (event) in
            guard let self = self, let state = event.element else { return }
            switch state {
                
            case .idle:
                break
            case .retrieved(_):
                let decision = self.viewModel.pokemons.count != 0
                self.stackView.isHidden = decision
                self.tableView.isHidden = !decision
                self.tableView.reloadData()
            }
            
        }.disposed(by: disposeBag)
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PokemonTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retrievePokemons()
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
        coordinatorDelegate?.toPokemonDetailed(savedDTO: SavedDTO(pokemon: viewModel.pokemons[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            PokemonKeychainPersistency().remove(key: viewModel.pokemons[indexPath.row].prettyName, onSuccess: {
                self.viewModel.retrievePokemons()
            }) {
                //Show alert message error
            }
        }
    }
    
}
