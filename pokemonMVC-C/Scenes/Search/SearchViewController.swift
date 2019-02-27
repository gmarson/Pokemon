//
//  ViewController.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 3/30/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import UIKit

protocol PokemonSearchCoordinatorDelegate {
    func toPokemonDetailed(pokemon: Pokemon)
}

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pikachuStackView: UIStackView!
    
    var coordinatorDelegate: PokemonSearchCoordinatorDelegate?
    private var pokemon: Pokemon? = nil
    private var currentPokemonImage: UIImage? = nil
    
    private let pokemonServices = PokemonServices()
    private lazy var errorAlert: UIAlertController = {
        let a = UIAlertController(title: "Oops", message: "Pokemon not found!", preferredStyle: UIAlertController.Style.alert)
        
        a.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        
        return a
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setupComponents() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PokemonTableViewCell.identifier)
    }

    private func searchPokemon() {
        
        guard let searchText = searchBar.text?.lowercased() else {
            return
        }
        
        pokemonServices.getPokemon(identifier: searchText, onSuccess: { (response, pokemon) in
            
            self.pokemon = pokemon
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
    
        }, onFailure: { (response) in
           
            DispatchQueue.main.async {
                self.tableView.isHidden = true
                self.present(self.errorAlert, animated: true, completion: nil)
            }
        })
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier) as! PokemonTableViewCell
        
        if let pokemon = pokemon {
            cell.setup(pokemon: pokemon)
            
            cell.pokemonImageView.kf.setImage(with: pokemon.sprites?.front_default) { (result) in
                switch result {
                    
                case .success(let content):
                    self.currentPokemonImage = content.image
                case .failure(_):
                    break
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemon = pokemon else { return }
        coordinatorDelegate?.toPokemonDetailed(pokemon: pokemon)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchPokemon()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        currentPokemonImage = nil
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.isHidden = true
    }
    
}

