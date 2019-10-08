//
//  PokemonDetailViewController.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 19/02/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit
import ReSwift

protocol DetailViewControllerProtocol: class {
    
}

class DetailViewController: UIViewController {

    @IBOutlet var statViews: [PokemonStatInfoView]!
    @IBOutlet private weak var pokemonTitle: UILabel!
    @IBOutlet private weak var pokemonImage: UIImageView!
    @IBOutlet private weak var baseExperienceLabel: UILabel!
    @IBOutlet private weak var abilityLabel: UILabel!
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var pokemonKeychainButton: PokemonKeychainButton!
    @IBOutlet weak var pokemonType1: PokemonTypeView!
    @IBOutlet weak var pokemonType2: PokemonTypeView!
    
    private var viewModel: DetailViewModel!
    
    class func newInstance(viewModel: DetailViewModel) -> DetailViewController {
        let viewController = DetailViewController.instantiate(viewControllerOfType: DetailViewController.self)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setButtonStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        
        store.subscribe(self) {
            $0.select({
                $0.detailState
            })
        }
    }
    
    deinit {
        store.unsubscribe(self)
    }
    
    private func handleKeychainError(error: KeychainErrors ) {
        self.present(UIAlertController.errorAlert(message: error.rawValue), animated: true, completion: nil)
    }
    
    private func setTitle() {
        title = viewModel.constants.title
    }
    
    private func setButtonStatus() {
        viewModel.isPokemonInDatabase ? pokemonKeychainButton.turnIntoDeleteButton() : pokemonKeychainButton.turnIntoAddButton()
    }
    
    private func setupScreen(pokemon: Pokemon) {
        pokemonTitle.text = pokemon.prettyName
        if let data = pokemon.pngImage {
            pokemonImage.image = UIImage(data: data)
        }
    
        baseExperienceLabel.text = viewModel.constants.baseExperience + pokemon.baseExperience
        if let species = pokemon.species {
            speciesLabel.text = viewModel.constants.species + species.prettyName
        }
        
        if let a = pokemon.commomAbility, let abilityName = a.ability?.prettyName {
            abilityLabel.text = viewModel.constants.ability + abilityName
        }
        
        pokemonType1.setup(types: pokemon.types, position: 0)
        pokemonType2.setup(types: pokemon.types, position: 1)
        setupStatViews(pokemon: pokemon)
    }
    
    private func setupStatViews(pokemon: Pokemon) {
        guard let stats = pokemon.stats, stats.count == statViews.count else { return }
        zip(statViews, stats).forEach { tuple in
            tuple.0.setup(tuple.1)
        }
    }

    @IBAction func addOrRemove(_ sender: PokemonKeychainButton) {
        viewModel.isPokemonInDatabase ? store.dispatch(removePokemonThunk(prettyName: viewModel.pokemon?.prettyName)) : store.dispatch(savePokemonThunk(pokemon: viewModel.pokemon))
    }
}

extension DetailViewController: StoreSubscriber {
    func newState(state: DetailState) {
        switch state {
            
        case .pokemonReceived(let pokemon):
            self.setupScreen(pokemon: pokemon)
        case .pokemonAdded:
            self.pokemonKeychainButton.turnIntoDeleteButton()
        case .pokemonRemoved:
            self.pokemonKeychainButton.turnIntoAddButton()
        case .keychainError(let errorType):
            self.handleKeychainError(error: errorType)
        case .idle:
            break
        }
    }
}
