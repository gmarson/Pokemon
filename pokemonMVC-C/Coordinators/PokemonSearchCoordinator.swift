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
        let searchViewController = SearchViewController.instantiate(viewControllerOfType: SearchViewController.self, storyboardName: "Main")
        self.searchViewController = searchViewController
        self.searchViewController?.coordinatorDelegate = self
        navigationController.viewControllers = [searchViewController]
        tabBarController.viewControllers = [navigationController]
    }
    
}

extension PokemonSearchCoordinator: PokemonSearchCoordinatorDelegate {
    func toPokemonDetailed() {
    
    }
    
    
}
