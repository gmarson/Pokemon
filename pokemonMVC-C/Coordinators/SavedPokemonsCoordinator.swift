//
//  SavedPokemonsCoordinator.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 19/02/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import Foundation
import UIKit



class SavedPokemonsCoordinator: Coordinator {
    
    private let tabBarController: UITabBarController
    private var savedPokemonsViewController: SavedPokemonsViewController?
    private let navigationController: UINavigationController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        navigationController = UINavigationController()
    }
    
    func start() {
        let savedPokemonsViewController = SavedPokemonsViewController(nibName: "SavedPokemonsViewController", bundle: nil)
        self.savedPokemonsViewController = savedPokemonsViewController
        navigationController.viewControllers = [savedPokemonsViewController]
        self.savedPokemonsViewController?.coordinatorDelegate = self
        tabBarController.viewControllers?.append(navigationController)
        tabBarController.tabBar.items?[1].title = "Saved"
        tabBarController.tabBar.items?[1].image = UIImage(named: "pokeball")
    }
}

extension SavedPokemonsCoordinator: SavedPokemonsCoordinatorDelegate {
    func toPokemonDetailed(savedDTO: SavedDTO) {
        let detailViewController = PokemonDetailViewController.init(nibName: "PokemonDetailViewController", bundle: nil)
        detailViewController.pokemon = savedDTO.pokemon
        navigationController.pushViewController(detailViewController, animated: true)
        
    }
}
