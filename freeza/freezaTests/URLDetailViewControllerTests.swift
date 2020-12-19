//
//  URLDetailViewControllerTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/18/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class URLDetailViewControllerTests: XCTestCase {
    
    var viewController: URLDetailViewController!
    var window: UIWindow!
    
    override func setUpWithError() throws {
        window = UIWindow()
        setupViewController()
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func setupViewController() {
        let storyboard = UIStoryboard(name: Storyboard.ReferenceName.urlDetail.rawValue, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? URLDetailViewController {
            self.viewController = viewController
        }
    }
    
    class URLDetailBusinessLogicSpy: URLDetailBusinessLogic {
        
        var requestUIInfoWasCalled = false
        var requestFavoriteActionWasCalled = false
        
        func requestUIInfo(request: URLDetail.UIInfo.Request) {
            requestUIInfoWasCalled = true
        }
        
        func requestFavoriteAction(request: URLDetail.FavoriteAction.Request) {
            requestFavoriteActionWasCalled = true
        }
    }
    
    func testViewDidLoadShouldRequestUIInfo() throws {
        let interactor = URLDetailBusinessLogicSpy()
        viewController.interactor = interactor
        TestUtilities.loadView(window: &window, viewController: viewController)
        
        viewController.viewDidLoad()
        
        XCTAssert(interactor.requestUIInfoWasCalled)
    }
    
    func testFavoriteButtonActionShouldRequestFavoriteAction() throws {
        let interactor = URLDetailBusinessLogicSpy()
        viewController.interactor = interactor
        TestUtilities.loadView(window: &window, viewController: viewController)
        
        viewController.viewDidLoad()
        
        viewController.didTapFavoriteButton(sender: self)
        
        XCTAssert(interactor.requestFavoriteActionWasCalled)
    }
}
