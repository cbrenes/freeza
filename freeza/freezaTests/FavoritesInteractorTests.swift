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
        interactor = FavoritesInteractor()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    }
}
