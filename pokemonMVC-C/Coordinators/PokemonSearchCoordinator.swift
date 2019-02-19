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
    private var searchViewController: SearchViewController?
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let searchViewController = SearchViewController.instantiate(viewControllerOfType: SearchViewController.self, storyboardName: "Main")
        self.searchViewController = searchViewController
        tabBarController.viewControllers = [searchViewController]
    }
    
}
