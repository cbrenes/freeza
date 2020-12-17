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
        func displaySomething(viewModel: Settings.Something.ViewModel) {
            
        }
    }
}
