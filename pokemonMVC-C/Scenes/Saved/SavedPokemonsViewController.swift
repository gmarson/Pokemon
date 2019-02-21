//
//  SavedPokemonsViewController.swift
//  pokemonMVC-C
//
//  Created by Zup on 19/02/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import UIKit

class SavedPokemonsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}
