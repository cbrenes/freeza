//
//  URLDetailPresenterTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/18/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class URLDetailPresenterTests: XCTestCase {
    
    var presenter: URLDetailPresenter!
    
    override func setUpWithError() throws {
        presenter = URLDetailPresenter()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class URLDetailDisplayLogicSpy: URLDetailDisplayLogic {
        
        var displayUIInfoWasCalled = false
        var displayFavoriteActionSuccessful = false
        var displayFavoriteActionErrorFound = false
        
        func displayUIInfo(viewModel: URLDetail.UIInfo.ViewModel) {
            displayUIInfoWasCalled = true
        }
        
        func displayFavoriteActionSuccessful(viewModel: URLDetail.FavoriteAction.ViewModel.Successful) {
            displayFavoriteActionSuccessful = true
        }
        
        func displayFavoriteActionErrorFound(viewModel: URLDetail.FavoriteAction.ViewModel.ErrorFound) {
            displayFavoriteActionErrorFound = true
        }
    }
    
    func testDisplayInfoShouldAskViewControllerToDisplayData() throws {
        let viewController = URLDetailDisplayLogicSpy()
        presenter.viewController = viewController
        
        presenter.presentUIInfo(response: URLDetail.UIInfo.Response(item: EntryModel(title: "title", author: "auhtor", creation: Date(), thumbnailURL: URL(string: "www.google.com"), commentsCount: 10, url: URL(string: "www.apple.com"), id: "123", isOver18: false)))
        
        XCTAssert(viewController.displayUIInfoWasCalled)
    }
    
    func testDisplayFavoriteShouldAskViewControllerToDisplaySuccessData() throws {
        let viewController = URLDetailDisplayLogicSpy()
        presenter.viewController = viewController
        
        presenter.presentFavoriteAction(response: URLDetail.FavoriteAction.Response(item: EntryModel(title: "title", author: "auhtor", creation: Date(), thumbnailURL: URL(string: "www.google.com"), commentsCount: 10, url: URL(string: "www.apple.com"), id: "123", isOver18: false), errorFound: nil))
        
        XCTAssert(viewController.displayFavoriteActionSuccessful)
    }
    
    func testDisplayFavoriteShouldAskViewControllerToDisplayErrorData() throws {
        let viewController = URLDetailDisplayLogicSpy()
        presenter.viewController = viewController
        
        presenter.presentFavoriteAction(response: URLDetail.FavoriteAction.Response(item: EntryModel(title: "title", author: "auhtor", creation: Date(), thumbnailURL: URL(string: "www.google.com"), commentsCount: 10, url: URL(string: "www.apple.com"), id: "123", isOver18: false), errorFound: "Error Found"))
        
        XCTAssert(viewController.displayFavoriteActionErrorFound)
    }
}
