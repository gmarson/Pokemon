//
//  ViewController.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 3/30/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import UIKit
import RxSwift

protocol PokemonSearchCoordinatorDelegate {
    func toPokemonDetailed(searchDTO: SearchDTO)
}

struct SearchDTO {
    let pokemon: Pokemon
}

class SearchViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var pikachuStackView: UIStackView!
    
    private var viewModel: SearchViewModel!
    private var disposeBag = DisposeBag()
    
    class func newInstance(viewModel: SearchViewModel) -> SearchViewController {
        let viewController = SearchViewController.instantiate(viewControllerOfType: SearchViewController.self)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func bind() {
        viewModel.viewState
            .subscribeOn(MainScheduler.instance)
            .subscribe { [weak self] (event) in
                guard let self = self, let state = event.element else { return }
                switch state {
                    
                case .idle:
                    break
                case .retrieved(_):
                    
                    DispatchQueue.main.async {
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    }
                    
                case .error(let error):
                    
                    DispatchQueue.main.async {
                        self.tableView.isHidden = true
                        self.present(UIAlertController.errorAlert(message: error.rawValue), animated: true, completion: nil)
                    }
                case .downloadedImage:
                    self.tableView.reloadData()
                }
        }.disposed(by: disposeBag)
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
        viewModel.toPokemonDetailed(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.searchPokemon(text: searchBar.text?.lowercased())
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.isHidden = true
    }
    
}

