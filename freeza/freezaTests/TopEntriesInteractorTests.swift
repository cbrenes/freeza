//
//  TopEntriesInteractorTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/18/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class TopEntriesInteractorTests: XCTestCase {
    
    var interactor: TopEntriesInteractor!
    
    override func setUpWithError() throws {
        RealmHelper.deleteAllDB()
        interactor = TopEntriesInteractor()
        interactor.apiWorker = APIWorker(store: RedditMockAPI())
    }
    
    override func tearDownWithError() throws {
        RealmHelper.deleteAllDB()
    }
    
    class TopEntriesPresentationLogicSpy: MainEntryPresentationLogic {
        
        var presentDataSourceWasCalled = false
        var presentDetailWasCalled = false
        var presentFavoriteWasCalled = false
        
        func presentDataSource(response: MainEntry.DataStore.Response) {
            presentDataSourceWasCalled = true
        }
        
        func presentDetail(response: MainEntry.Detail.Response) {
            presentDetailWasCalled = true
        }
        
        func presentFavorite(response: MainEntry.Favorite.Response) {
            presentFavoriteWasCalled = true
        }
    }
    
    
    func testRequestDataSourceShouldCallPresenterToFormatData() throws {
        let presenter = TopEntriesPresentationLogicSpy()
        interactor.presenter = presenter
        
        interactor.requestDataStore(request: MainEntry.DataStore.Request())
        TimerHelperTests().wait(for: 1) // This wait is neccesary because the app should wait to retrieve the data of the DB
        
        XCTAssert(presenter.presentDataSourceWasCalled)
    }
    
    func testRequestDetailShouldCallPresenterToFormatData() throws {
        let presenter = TopEntriesPresentationLogicSpy()
        interactor.presenter = presenter
        interactor.apiEntries = [EntryModel(title: "", author: "", creation: Date(), thumbnailURL: nil, commentsCount: 0, url: nil, id: "1", isOver18: true)]
        
        interactor.requestDetail(request: MainEntry.Detail.Request(indexPath: IndexPath(row: 0, section: 0)))
        
        XCTAssert(presenter.presentDetailWasCalled)
    }
    
    func testRequestPresentFavoriteShouldCallPresenterToFormatData() throws {
        let presenter = TopEntriesPresentationLogicSpy()
        interactor.presenter = presenter
        interactor.apiEntries = [EntryModel(title: "", author: "", creation: Date(), thumbnailURL: nil, commentsCount: 0, url: nil, id: "1", isOver18: true)]
        
        interactor.validateInformationWithDB(errorMessage: nil)
        interactor.requestFavorite(request: MainEntry.Favorite.Request(indexPath: IndexPath(row: 0, section: 0)))
        TimerHelperTests().wait(for: 1) // This wait is neccesary because the app should wait to retrieve the data of the DB
        
        XCTAssert(presenter.presentFavoriteWasCalled)
    }
}
