//
//  DetailTests.swift
//  PokemonTrackerTests
//
//  Created by Gabriel M on 4/22/19.
//  Copyright © 2019 Gabriel M. All rights reserved.
//

import XCTest
@testable import PokemonTracker

class DetailTests: XCTestCase {
    
    var viewModel: DetailViewModel!
    var pokemon: Pokemon!
    
    override func setUp() {
        pokemon =  try! JSONDecoder().decode(Pokemon.self, from: PokemonServices().mock)
        viewModel = DetailViewModel(pokemon: pokemon)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


}
