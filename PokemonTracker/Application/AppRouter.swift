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

enum RoutingDestination: String {
    case search = "MenuTableViewController"
    case saved = "CategoriesTableViewController"
    case detail = "GameViewController"
}

final class AppRouter {
    
    var rootViewController: TabBarViewController
    
    init(root: TabBarViewController) {
        rootViewController = root
        
        store.subscribe(self) {
            $0.select {
                $0.routingState
            }
        }
    }
    
}

 // MARK: - StoreSubscriber

extension AppRouter: StoreSubscriber {
    func newState(state: RoutingState) {
        
        switch state.navigationState {
            
        case .search:
            break
        case .saved:
            break
        case .detail:
            break
        
        }
        
        // 5
        //pushViewController(identifier: state.navigationState.rawValue, animated: true)
    }
}
