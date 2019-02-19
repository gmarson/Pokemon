//
//  SavedPokemonsCoordinator.swift
//  pokemonMVC-C
//
//  Created by Zup on 19/02/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import Foundation
import UIKit

class SavedPokemonsCoordinator: Coordinator {
    
    private let tabBarController: UITabBarController
    private var savedPokemonsViewController: SavedPokemonsViewController?
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let savedPokemonsViewController = SavedPokemonsViewController.instantiate(viewControllerOfType: SavedPokemonsViewController.self, storyboardName: "Main")
        self.savedPokemonsViewController = savedPokemonsViewController
        tabBarController.viewControllers?.append(savedPokemonsViewController)
    }
    
}
