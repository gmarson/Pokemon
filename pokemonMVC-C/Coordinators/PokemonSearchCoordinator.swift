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
    
    private let tabBarController: UITabBarController
    private let navigationController: UINavigationController
    private var searchViewController: SearchViewController?
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let searchViewController = SearchViewController(nibName: "SearchViewController", bundle: nil)
        self.searchViewController = searchViewController
        self.searchViewController?.coordinatorDelegate = self
        navigationController.viewControllers = [searchViewController]
        tabBarController.viewControllers = [navigationController]
        tabBarController.tabBar.items?[0].title = "Search"
        tabBarController.tabBar.items?[0].image = UIImage(named: "gengar")
    }
    
}

extension PokemonSearchCoordinator: PokemonSearchCoordinatorDelegate {
    func toPokemonDetailed() {
    
    }
    
    
}
