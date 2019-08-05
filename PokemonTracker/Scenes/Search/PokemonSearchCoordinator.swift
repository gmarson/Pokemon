//
//  PokemonListCoordinator.swift
//  pokemonMVC-C
//
//  Created by Gabriel M on 11/3/18.
//  Copyright © 2018 Gabriel M. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

class PokemonSearchCoordinator: Coordinator {
    
    private let tabBarController: UITabBarController
    private let navigationController: UINavigationController
    private var searchViewController: SearchViewController?
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.navigationController = UINavigationController()
    }
    
    func start() {
        
        let searchViewController = SearchViewController.newInstance()
        
        let viewModel = SearchViewModel()
        viewModel.coordinatorDelegate = self
        
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
        let viewModel = DetailViewModel(pokemon: searchDTO.pokemon)
        let detailViewController = DetailViewController.newInstance(viewModel: viewModel)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
