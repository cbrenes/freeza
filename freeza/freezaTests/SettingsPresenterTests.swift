//
//  SettingsPresenterTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class SettingsPresenterTests: XCTestCase {
    
    var presenter: SettingsPresenter!

    override func setUpWithError() throws {
        presenter = SettingsPresenter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class SettingsDisplayLogicSpy: SettingsDisplayLogic {
        
        var displayDataSourceWasCalled = false
        var displayDataSourceViewModel: Settings.DataSource.ViewModel?
        
        func displayDataSource(viewModel: Settings.DataSource.ViewModel) {
            displayDataSourceWasCalled = true
            displayDataSourceViewModel = viewModel
        }
    }
    
    func testPresentShouldAskViewControllerToDisplayData() throws {
        let viewController = SettingsDisplayLogicSpy()
        presenter.viewController = viewController
        
        presenter.presentDataSource(response: Settings.DataSource.Response(items: [Settings.Item(type: .safe, value: true)]))
        
        XCTAssert(viewController.displayDataSourceWasCalled)
        XCTAssertEqual(viewController.displayDataSourceViewModel?.items.first?.title, Localized.Strings.safe.rawValue)
        XCTAssertEqual(viewController.displayDataSourceViewModel?.items.first?.value, true)
    }
}
