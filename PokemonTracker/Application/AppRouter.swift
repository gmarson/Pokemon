//
//  AppRouter.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 29/07/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift
import UIKit

final class AppRouter: Coordinator {
    
    let window: UIWindow
    let rootViewController: UITabBarController
    let pokemonSearchCoordinator: PokemonSearchCoordinator
    let savedPokemonsCoordinator: SavedPokemonsCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = TabBarViewController.instantiate(viewControllerOfType: TabBarViewController.self, storyboardName: "Main")
        rootViewController.viewControllers = []
        
        pokemonSearchCoordinator = PokemonSearchCoordinator(tabBarController: rootViewController)
        savedPokemonsCoordinator = SavedPokemonsCoordinator(tabBarController: rootViewController)
        
        store.subscribe(self) {
            $0.select {
                $0.routingState
            }
        }
    }
    
    func start() {
        window.rootViewController = rootViewController
        store.dispatch(SearchRouteAction())
        store.dispatch(SavedRouteAction())
        window.makeKeyAndVisible()
    }
    
    deinit {
        store.unsubscribe(self)
    }
}

// MARK: - StoreSubscriber
extension AppRouter: StoreSubscriber {
    func newState(state: RoutingState) {
        print("new state on coordinator")
        switch state {
        case .search:
            pokemonSearchCoordinator.start()
        case .saved:
            savedPokemonsCoordinator.start()
        case .detail(let requestingCoordinator):
            //rootViewController.viewControllers[1]
           
            
            break
//            let viewModel = DetailViewModel(pokemon: searchDTO.pokemon)
//            let detailViewController = DetailViewController.newInstance(viewModel: viewModel)
//            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
