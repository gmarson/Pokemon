//
//  DetailTests.swift
//  PokemonTests
//
//  Created by Gabriel Marson on 05/04/19.
//  Copyright © 2019 Gabriel Marson. All rights reserved.
//

import XCTest
@testable import Pokemon

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

    func testRemoval() {
        //given
        viewModel.saveToDatabase()
        
        //when
        viewModel.removeFromDatabase()
        let value = try! viewModel.viewState.value()
        
        //then
        XCTAssert(value == DetailViewState.pokemonRemoved)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
