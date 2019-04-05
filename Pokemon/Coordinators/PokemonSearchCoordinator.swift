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
        let viewModel = SearchViewModel()
        viewModel.coordinatorDelegate = self
        let searchViewController = SearchViewController.newInstance(viewModel: viewModel)
        self.searchViewController = searchViewController
        navigationController.viewControllers = [searchViewController]
        setupTabBar()
    }

    private func setupTabBar() {
        tabBarController.viewControllers = [navigationController]
        tabBarController.tabBar.items?[0].title = "Search"
        tabBarController.tabBar.items?[0].image = UIImage(named: "gengar")
    }
}

extension PokemonSearchCoordinator: PokemonSearchCoordinatorDelegate {
    func toPokemonDetailed(searchDTO: SearchDTO) {
        let detailViewController = PokemonDetailViewController.init(nibName: "PokemonDetailViewController", bundle: nil)
        detailViewController.pokemon = searchDTO.pokemon
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
