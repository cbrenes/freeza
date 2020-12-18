//
//  TopEntriesViewControllerTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/18/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class TopEntriesViewControllerTests: XCTestCase {

    var viewController: TopEntriesViewController!
    var window: UIWindow!
    
    override func setUpWithError() throws {
        window = UIWindow()
        setupViewController()
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func setupViewController() {
        let storyboard = UIStoryboard(name: Storyboard.ReferenceName.topEntry.rawValue, bundle: nil)
        if let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController, let viewController = navigationController.viewControllers.first as? TopEntriesViewController {
            self.viewController = viewController
        }
    }
    
    class TopEntryBusinessLogicSpy: MainEntryBusinessLogic {
        
        var presenter: MainEntryPresentationLogic?
    
        var requestDataStoreWasCalled = false
        var requestDetailWasCalled = false
        
        func requestDataStore(request: MainEntry.DataStore.Request) {
            requestDataStoreWasCalled = true
        }
        
        func requestDetail(request: MainEntry.Detail.Request) {
            requestDetailWasCalled = true
        }
    }
    
    func testViewDidLoadShouldRequestDataSource() throws {
        let interactor = TopEntryBusinessLogicSpy()
        viewController.interactor = MainEntryInteractor(businessLogic: interactor)
        TestUtilities.loadView(window: &window, viewController: viewController)
        
        viewController.viewDidLoad()
        
        XCTAssert(interactor.requestDataStoreWasCalled)
    }
    
    func testViewDidLoadShouldCallAMethodToRegisterTheCustomCells() throws {
        let interactor = TopEntryBusinessLogicSpy()
        viewController.interactor = MainEntryInteractor(businessLogic: interactor)
        TestUtilities.loadView(window: &window, viewController: viewController)

        let tableView = TableViewSpy()
        viewController.tableView = tableView
        viewController.viewDidLoad()

        XCTAssert(tableView.registerForCellReuseIdentifierWasCalled)
    }
    
    func testDidSelectRowShouldRequestDetail() throws {
        let interactor = TopEntryBusinessLogicSpy()
        viewController.interactor = MainEntryInteractor(businessLogic: interactor)
        TestUtilities.loadView(window: &window, viewController: viewController)
        
        viewController.viewDidLoad()
        
        viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssert(interactor.requestDetailWasCalled)
    }
}
