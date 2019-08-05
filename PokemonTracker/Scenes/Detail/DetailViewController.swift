//
//  PokemonDetailViewController.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 19/02/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit
import RxSwift

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
    private var disposeBag = DisposeBag()
    
    private struct Constants {
        let baseExperience = "Base Experience: "
        let species = "Species: "
        let ability = "Ability: "
        let failToAdd = "This pokemon could not be added"
        let failToRemove = "This pokemon could not be removed"
        let title = "Details"
    }
    
    private let constants = Constants()
    
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
        bind()
        setTitle()
    }
    
    private func bind() {
        viewModel.viewState
            .subscribeOn(MainScheduler.instance)
            .subscribe { [weak self] (event) in
                guard let self = self, let state = event.element else { return }
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
            
        }.disposed(by: disposeBag)
    }
    
    private func handleKeychainError(error: DetailKeychainError ) {
        var message = ""
        switch error {
        case .failToDelete:
            message = constants.failToRemove
        case .failToAdd:
            message = constants.failToAdd
        }
        
        self.present(UIAlertController.errorAlert(message: message), animated: true, completion: nil)
    }
    
    private func setTitle() {
        title = constants.title
    }
    
    private func setButtonStatus() {
        viewModel.isPokemonInDatabase ? pokemonKeychainButton.turnIntoDeleteButton() : pokemonKeychainButton.turnIntoAddButton()
    }
    
    private func setupScreen(pokemon: Pokemon) {
        pokemonTitle.text = pokemon.prettyName
        if let data = pokemon.pngImage {
            pokemonImage.image = UIImage(data: data)
        }
    
        baseExperienceLabel.text = constants.baseExperience + pokemon.baseExperience
        if let species = pokemon.species {
            speciesLabel.text = constants.species + species.prettyName
        }
        
        if let a = pokemon.commomAbility, let abilityName = a.ability?.prettyName {
            abilityLabel.text = constants.ability + abilityName
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
        viewModel.addOrRemoveFromDatabase()
    }
    
}
