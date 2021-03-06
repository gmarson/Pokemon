//
//  PokemonListCoordinator.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 11/3/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation
import UIKit

class PokemonSearchCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private var searchViewController: SearchViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController.instantiate(viewControllerOfType: SearchViewController.self, storyboardName: "Main")
        searchViewController.title = "Search Pokemon"
        self.searchViewController = searchViewController
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
}
