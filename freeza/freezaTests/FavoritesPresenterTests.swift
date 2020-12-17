//
//  FavoritesPresenterTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class FavoritesPresenterTests: XCTestCase {
    
    var presenter: FavoritesPresenter!

    override func setUpWithError() throws {
        presenter = FavoritesPresenter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    class FavoritesDisplayLogicSpy: FavoritesDisplayLogic {
        func displaySomething(viewModel: Favorites.Something.ViewModel) {
            
        }
    }
}
