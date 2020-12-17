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
        let storyboard = UIStoryboard(name: Storyboard.ReferenceName.settings.rawValue, bundle: nil)
        if let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController, let viewController = navigationController.viewControllers.first as? SettingsViewController {
            self.viewController = viewController
        }
    }
    
    class SettingsBussinesLogicSpy: SettingsBusinessLogic {
        
        var requestDataSourceWasCalled = false
        var requestSetValueWasCalled = false
        
        func requestDataSource(request: Settings.DataSource.Request) {
            requestDataSourceWasCalled = true
        }
        
        func requestSetValue(request: Settings.SetValue.Request) {
            requestSetValueWasCalled = true
        }
    }
    
    func testViewDidLoadShouldCallAMethodToRegisterTheCustomCells() throws {
        let interactor = SettingsBussinesLogicSpy()
        viewController.interactor = interactor
        TestUtilities.loadView(window: &window, viewController: viewController)
        
        let tableView = TableViewSpy()
        viewController.tableView = tableView
        viewController.viewDidLoad()
        
        XCTAssert(tableView.registerForCellReuseIdentifierWasCalled)
    }
    
    func testViewDidLoadShouldRequestDataSource() throws {
        let interactor = SettingsBussinesLogicSpy()
        viewController.interactor = interactor
        TestUtilities.loadView(window: &window, viewController: viewController)
        
        viewController.viewDidLoad()
        
        XCTAssert(interactor.requestDataSourceWasCalled)
    }
    
    func testCellForRowAtDisplayCorrectInfo() throws {
        let interactor = SettingsBussinesLogicSpy()
        viewController.interactor = interactor
        let dataSource = [Settings.ItemToDisplay(title: "test", value: false)]
        TestUtilities.loadView(window: &window, viewController: viewController)
        
        viewController.displayDataSource(viewModel: Settings.DataSource.ViewModel(items: dataSource))
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(item: 0, section: 0)) as! SettingsCustomTableViewCell
        
        XCTAssertEqual(cell.leftLabel.text, dataSource.first?.title)
        XCTAssertEqual(cell.switchOutlet.isOn, dataSource.first?.value)
    }
    
    func testNumberOfItemsPerSectionInTheTableShouldBeEqualToTheNumberOfRowsPerSectionToDisplay() throws {
        let interactor = SettingsBussinesLogicSpy()
        viewController.interactor = interactor
        let dataSource = [Settings.ItemToDisplay(title: "test", value: false)]
        TestUtilities.loadView(window: &window, viewController: viewController)
        
        viewController.displayDataSource(viewModel: Settings.DataSource.ViewModel(items: dataSource))
        let numberOfRows = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(numberOfRows, dataSource.count)
    }
    
    func testSwitchActionShouldRequestSetValue() throws {
        let interactor = SettingsBussinesLogicSpy()
        viewController.interactor = interactor
        let dataSource = [Settings.ItemToDisplay(title: "test", value: false)]
        TestUtilities.loadView(window: &window, viewController: viewController)
        let switchOutlet = UISwitch()
        switchOutlet.isOn = true
        
        viewController.displayDataSource(viewModel: Settings.DataSource.ViewModel(items: dataSource))
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(item: 0, section: 0)) as! SettingsCustomTableViewCell
        cell.switchAction(switchOutlet)
        
        XCTAssert(interactor.requestSetValueWasCalled)
    }
}
