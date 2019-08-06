//
//  AppRouter.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 29/07/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift
import UIKit

enum RoutingDestination {
    case search
    case saved
    case detail(requestingCoordinator: Coordinator)
}

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
        store.dispatch(RoutingAction(destination: .search))
        store.dispatch(RoutingAction(destination: .saved))
        window.makeKeyAndVisible()
    }
}

// MARK: - StoreSubscriber
extension AppRouter: StoreSubscriber {
    func newState(state: RoutingState) {
        switch state.navigationState {
        case .search:
            pokemonSearchCoordinator.start()
        case .saved:
            savedPokemonsCoordinator.start()
        case .detail(let requestingCoordinator):
            break
//            let viewModel = DetailViewModel(pokemon: searchDTO.pokemon)
//            let detailViewController = DetailViewController.newInstance(viewModel: viewModel)
//            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
