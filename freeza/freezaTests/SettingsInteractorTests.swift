//
//  SettingsInteractorTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class SettingsInteractorTests: XCTestCase {
    
    var interactor: SettingsInteractor!

    override func setUpWithError() throws {
        interactor = SettingsInteractor()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class SettingsPresentationLogicSpy: SettingsPresentationLogic {
        
        var presentDataSourceWasCalled = false
        
        func presentDataSource(response: Settings.DataSource.Response) {
            presentDataSourceWasCalled = true
        }
    }
    
    class LocalQuickStorageWorkerSpy: LocalQuickStorageWorker {
        
        var saveWasCalled = false
        
        override func save(value: Any, key: String) {
            saveWasCalled = true
        }
    }
    
    func testRequestDataSourceShouldAskPresenterToFormatData() throws {
        let presenter = SettingsPresentationLogicSpy()
        interactor.presenter = presenter
        
        interactor.requestDataSource(request: Settings.DataSource.Request())
        
        XCTAssertEqual(interactor.items.count, 1, "The app should show 1 row")
        XCTAssertEqual(interactor.items.first?.type, .safe, "The app should show safe type as first option")
        XCTAssert(presenter.presentDataSourceWasCalled)
    }
    
    func testSetValueSavesTheValueInTheWorker() throws {
        let presenter = SettingsPresentationLogicSpy()
        interactor.presenter = presenter
        let worker = LocalQuickStorageWorkerSpy(store: UserDefaultsService())
        interactor.localQuickStorageWorker = worker
        interactor.items = [Settings.Item(type: .safe, value: false)]
        
        interactor.requestSetValue(request: Settings.SetValue.Request(indexPath: IndexPath(item: 0, section: 0), value: true))
        
        XCTAssert(worker.saveWasCalled)
        XCTAssert(interactor.items.first?.value ?? false)
    }
}
