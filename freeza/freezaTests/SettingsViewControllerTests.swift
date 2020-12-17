//
//  SettingsViewControllerTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class SettingsViewControllerTests: XCTestCase {
    
    var viewController: SettingsViewController!
    var window: UIWindow!

    override func setUpWithError() throws {
        window = UIWindow()
        setupViewController()
    }

    override func tearDownWithError() throws {
        
    }
    
    func setupViewController() {
        let storyboard = UIStoryboard(name: Storyboard.ReferenceName.Settings.rawValue, bundle: nil)
        if let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController, let viewController = navigationController.viewControllers.first as? SettingsViewController {
            self.viewController = viewController
        }
    }
    
    class SettingsBussinesLogicSpy: SettingsBusinessLogic {
        
        func doSomething(request: Settings.Something.Request) {
            
        }
    }
}
