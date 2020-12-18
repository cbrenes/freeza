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
        var requestFavoriteWasCalled = false
        
        func requestDataStore(request: MainEntry.DataStore.Request) {
            requestDataStoreWasCalled = true
        }
        
        func requestDetail(request: MainEntry.Detail.Request) {
            requestDetailWasCalled = true
        }
        
        func requestFavorite(request: MainEntry.Favorite.Request) {
            requestFavoriteWasCalled = true
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

    
    func testCellForRowAtDisplayCorrectInfo() throws {
        let interactor = TopEntryBusinessLogicSpy()
        viewController.interactor = MainEntryInteractor(businessLogic: interactor)
        TestUtilities.loadView(window: &window, viewController: viewController)
        
        viewController.viewDidLoad()
        viewController.items = [MainEntry.ItemToDisplay(thumbnailImageURL: URL(string: "www.google.com"), author: "author", commentCount: "39", time: "time", title: "title", heartImage: UIImage(named: Assets.images.heartEnabled.rawValue), shouldHideContent: false)]
       
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(item: 0, section: 0)) as! EntryCustomTableViewCell
        
        XCTAssertEqual(cell.authorLabel.text, viewController.items.first?.author)
        XCTAssertEqual(cell.ageLabel.text, viewController.items.first?.time)
        XCTAssertEqual(cell.commentsCountLabel.text, viewController.items.first?.commentCount)
        XCTAssertEqual(cell.entryTitleLabel.text, viewController.items.first?.title)
        XCTAssertEqual(cell.favoriteImageView.image, viewController.items.first?.heartImage)
    }
    
    func testEntryCustomTableViewCellHasSetTheDelegates() throws {
        let interactor = TopEntryBusinessLogicSpy()
        viewController.interactor = MainEntryInteractor(businessLogic: interactor)
        TestUtilities.loadView(window: &window, viewController: viewController)
        
        viewController.viewDidLoad()
        viewController.items = [MainEntry.ItemToDisplay(thumbnailImageURL: URL(string: "www.google.com"), author: "author", commentCount: "39", time: "time", title: "title", heartImage: UIImage(named: Assets.images.heartEnabled.rawValue), shouldHideContent: false)]
       
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(item: 0, section: 0)) as! EntryCustomTableViewCell
        cell.favoriteIconWasTouched(self)
        

        XCTAssert(interactor.requestFavoriteWasCalled)
    }
    
    func testDisplayDataSourceShouldReloadTableView() {
        let interactor = TopEntryBusinessLogicSpy()
        viewController.interactor = MainEntryInteractor(businessLogic: interactor)
        TestUtilities.loadView(window: &window, viewController: viewController)
        
        let tableView = TableViewSpy()
        viewController.tableView = tableView
        let items = [MainEntry.ItemToDisplay(thumbnailImageURL: URL(string: "www.google.com"), author: "author", commentCount: "39", time: "time", title: "title", heartImage: UIImage(named: Assets.images.heartEnabled.rawValue), shouldHideContent: false)]
        viewController.displayDataSourceSuccessFul(viewModel: MainEntry.DataStore.ViewModel.Successful(items: items))
        
        XCTAssert(tableView.reloadDataWasCalled)
    }
    
    func testDisplayFavoriteReloadTheCell() {
        let interactor = TopEntryBusinessLogicSpy()
        viewController.interactor = MainEntryInteractor(businessLogic: interactor)
        TestUtilities.loadView(window: &window, viewController: viewController)
        var item = MainEntry.ItemToDisplay(thumbnailImageURL: URL(string: "www.google.com"), author: "author", commentCount: "39", time: "time", title: "title", heartImage: UIImage(named: Assets.images.heartEnabled.rawValue), shouldHideContent: false)
        
        viewController.items = [item]
        viewController.tableView.reloadData()
        item.author = "testesterer"
        viewController.items = [item]
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(item: 0, section: 0)) as! EntryCustomTableViewCell
        
        XCTAssertEqual(cell.authorLabel.text, item.author)
    }
}
