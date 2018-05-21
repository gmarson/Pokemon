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
    
    init(window : UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        
        let emptyViewController = UIViewController()
        emptyViewController.view.backgroundColor = .cyan
        rootViewController.pushViewController(emptyViewController, animated: false)
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
