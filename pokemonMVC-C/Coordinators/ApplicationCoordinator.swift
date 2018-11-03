//
//  ApplicationCoordinator.swift
//  pokemonMVC-C
//
//  Created by Zup on 15/05/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import UIKit


class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UINavigationController
    let pokemonSearchCoordinator: PokemonSearchCoordinator

    
    init(window : UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        
        pokemonSearchCoordinator = PokemonSearchCoordinator(navigationController: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        pokemonSearchCoordinator.start()
        window.makeKeyAndVisible()
    }
}
