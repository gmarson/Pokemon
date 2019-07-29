//
//  AppRouter.swift
//  PokemonTracker
//
//  Created by Gabriel Marson on 29/07/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import ReSwift
import UIKit

//https://willowtreeapps.com/ideas/app-coordinators-and-redux-on-ios

final class AppRouter {
    
    let window: UIWindow
    let rootViewController: UITabBarController
    
    init(window : UIWindow) {
        self.window = window
        rootViewController = TabBarViewController.instantiate(viewControllerOfType: TabBarViewController.self, storyboardName: "Main")
        rootViewController.viewControllers = []
        
        store.subscribe(self) {
            $0.select {
                $0.routingState
            }
        }
        
    }
    
    // 2
    private func pushViewController(identifier: String, animated: Bool) {
        let viewController = instantiateViewController(identifier: identifier)
        rootViewController.pushViewController(viewController, animated: animated)
    }

    private func instantiateViewController(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}

 // MARK: - StoreSubscriber

extension AppRouter: StoreSubscriber {
    func newState(state: RoutingState) {
        
        // 5
        pushViewController(identifier: state.navigationState.rawValue, animated: true)
    }
}
