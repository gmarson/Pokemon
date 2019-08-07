//
//  ViewController.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 3/30/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import UIKit
import RxSwift
import ReSwift

class SearchViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var pikachuStackView: UIStackView!
    
    private var viewModel: SearchViewModel!
    
    class func newInstance(viewModel: SearchViewModel) -> SearchViewController {

        let vc = SearchViewController.instantiate(viewControllerOfType: SearchViewController.self)
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        store.subscribe(self) { $0.select(SearchState.init) }
        
//        store.subscribe(self) {
//            $0.select({
//                SearchState.init
//            })
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        store.unsubscribe(self)
    }

    private func setupComponents() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PokemonTableViewCell.identifier)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier) as! PokemonTableViewCell
        cell.setup(pokemon: viewModel.pokemon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //viewModel.toPokemonDetailed(index: indexPath.row) TODO: dispatch action
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text?.lowercased() else { return }
        
        store.dispatch(fetchPokemonThunk(pokemonName: text))
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.isHidden = true
    }
}

extension SearchViewController: StoreSubscriber {
    
    func newState(state: SearchState) {
        
        print("New state on Search view Controller")
        switch state.currentViewState {
            
        case .idle:
            break
        case .retrieved(let pokemon):
            self.viewModel.pokemon = pokemon
            self.tableView.isHidden = false
            self.tableView.reloadData()
            store.dispatch(downloadPokemonImageThunk)
            
        case .error(let error):
            
            self.tableView.isHidden = true
            self.present(UIAlertController.errorAlert(message: error.rawValue), animated: true, completion: nil)
        
        case .downloadedImage(let image):
            self.viewModel.pokemon.pngImage = image
            self.tableView.reloadData()
        }
    }
    
}
