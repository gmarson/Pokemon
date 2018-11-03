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
        let kanjiListViewController = SearchViewController(nibName: nil, bundle: nil)
        kanjiListViewController.title = "Search Pokemon"
        self.searchViewController = kanjiListViewController
        navigationController.pushViewController(kanjiListViewController, animated: true)
    }
    
}
