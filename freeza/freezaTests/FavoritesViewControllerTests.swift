//
//  FavoritesViewControllerTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class FavoritesViewControllerTests: XCTestCase {
    
    var viewController: FavoritesViewController!
    var window: UIWindow!

    override func setUpWithError() throws {
        window = UIWindow()
        setupViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func setupViewController() {
        let storyboard = UIStoryboard(name: Storyboard.ReferenceName.Favorites.rawValue, bundle: nil)
        if let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController, let viewController = navigationController.viewControllers.first as? FavoritesViewController {
            self.viewController = viewController
        }
    }
}
