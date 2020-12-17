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
        func presentSomething(response: Settings.Something.Response) {
            
        }
    }
}
