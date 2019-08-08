//
//  ApplicationCoordinator.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 15/05/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import UIKit


class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UITabBarController
    let pokemonSearchCoordinator: PokemonSearchCoordinator
    let savedPokemonsCoordinator: SavedPokemonsCoordinator
    //let appRouter: AppRouter
    
    init(window : UIWindow) {
        self.window = window
        rootViewController = TabBarViewController.instantiate(viewControllerOfType: TabBarViewController.self, storyboardName: "Main")
        rootViewController.viewControllers = []
        
        pokemonSearchCoordinator = PokemonSearchCoordinator(tabBarController: rootViewController)
        savedPokemonsCoordinator = SavedPokemonsCoordinator(tabBarController: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        pokemonSearchCoordinator.start()
        savedPokemonsCoordinator.start()
        window.makeKeyAndVisible()
    }
}
