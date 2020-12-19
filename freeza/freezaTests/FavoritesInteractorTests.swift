//
//  FavoritesInteractorTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class FavoritesInteractorTests: XCTestCase {
    
    var interactor: FavoritesInteractor!
    
    override func setUpWithError() throws {
        RealmHelper.deleteAllDB()
        interactor = FavoritesInteractor()
        interactor.entriesDataSource = [EntryModel(title: "title", author: "author", creation: Date(), thumbnailURL: nil, commentsCount: 0, url: nil, id: "1", isOver18: true)]
    }
    
    override func tearDownWithError() throws {
        RealmHelper.deleteAllDB()
    }
    
    class FavoritesPresentationLogicSpy: MainEntryPresentationLogic {
        
        var presentDataSourceWasCalled = false
        var presentDetailWasCalled = false
        
        func presentDataSource(response: MainEntry.DataStore.Response) {
            presentDataSourceWasCalled = true
        }
        
        func presentDetail(response: MainEntry.Detail.Response) {
            presentDetailWasCalled = true
        }
        
        func presentFavorite(response: MainEntry.Favorite.Response) {
            // this delegate isn't necessary for this scene
        }
    }
    
    func testRequestDataSourceShouldAskPresenterToFormatData() throws {
        let presenter = FavoritesPresentationLogicSpy()
        interactor.presenter = presenter
        
        interactor.requestDataStore(request: MainEntry.DataStore.Request())
        
        XCTAssert(presenter.presentDataSourceWasCalled)
    }
    
    func testRequestDetailShouldAskPresenterToFormatData() throws {
        let presenter = FavoritesPresentationLogicSpy()
        interactor.presenter = presenter
        
        interactor.requestDetail(request: MainEntry.Detail.Request(indexPath: IndexPath(row: 0, section: 0)))
        
        XCTAssert(presenter.presentDetailWasCalled)
    }
}
