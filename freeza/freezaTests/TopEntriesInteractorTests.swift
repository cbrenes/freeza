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
        interactor = TopEntriesInteractor()
        interactor.apiWorker = APIWorker(store: RedditMockAPI())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class TopEntriesPresentationLogicSpy: MainEntryPresentationLogic {
        
        var presentDataSourceWasCalled = false
        var presentDetailWasCalled = false
        
        func presentDataSource(response: MainEntry.DataStore.Response) {
            presentDataSourceWasCalled = true
        }
        
        func presentDetail(response: MainEntry.Detail.Response) {
            presentDetailWasCalled = true
        }
    }
    
    
    func testRequestDataSourceShouldCallPresenterToFormatData() throws {
        let presenter = TopEntriesPresentationLogicSpy()
        interactor.presenter = presenter
        
        interactor.requestDataStore(request: MainEntry.DataStore.Request())
        
        XCTAssert(presenter.presentDataSourceWasCalled)
    }
    
    func testRequestDetailShouldCallPresenterToFormatData() throws {
        let presenter = TopEntriesPresentationLogicSpy()
        interactor.presenter = presenter
        interactor.apiEntries = [EntryModel(title: "", author: "", creation: Date(), thumbnailURL: nil, commentsCount: 0, url: nil, id: 1, isOver18: true)]
        
        interactor.requestDetail(request: MainEntry.Detail.Request(indexPath: IndexPath(row: 0, section: 0)))
        
        XCTAssert(presenter.presentDetailWasCalled)
    }
}
