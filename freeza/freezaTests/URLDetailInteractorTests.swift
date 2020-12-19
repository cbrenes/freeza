//
//  URLDetailInteractorTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/18/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class URLDetailInteractorTests: XCTestCase {
    
    var interactor: URLDetailInteractor!
    
    override func setUpWithError() throws {
        RealmHelper.deleteAllDB()
        interactor = URLDetailInteractor()
        interactor.item = EntryModel(title: "title", author: "auhtor", creation: Date(), thumbnailURL: URL(string: "www.google.com"), commentsCount: 10, url: URL(string: "www.apple.com"), id: "123", isOver18: false)
    }
    
    override func tearDownWithError() throws {
        RealmHelper.deleteAllDB()
    }
    
    class URLDetailPresentationLogicSpy: URLDetailPresentationLogic {
        
        var presentUIInfoWasCalled = false
        var presentFavoriteActionWasCalled = false
        
        func presentUIInfo(response: URLDetail.UIInfo.Response) {
            presentUIInfoWasCalled = true
        }
        
        func presentFavoriteAction(response: URLDetail.FavoriteAction.Response) {
            presentFavoriteActionWasCalled = true
        }
    }
    
    func testRequestUIInfoShouldAskPresenterToFormatData() throws {
        let presenter = URLDetailPresentationLogicSpy()
        interactor.presenter = presenter
        
        interactor.requestUIInfo(request: URLDetail.UIInfo.Request())
        
        XCTAssert(presenter.presentUIInfoWasCalled)
    }
    
    func testRequestFavoriteActionShouldAskPresenterToFormatData() throws {
        let presenter = URLDetailPresentationLogicSpy()
        interactor.presenter = presenter
        
        interactor.requestFavoriteAction(request: URLDetail.FavoriteAction.Request())
        
        XCTAssert(presenter.presentFavoriteActionWasCalled)
    }
}
