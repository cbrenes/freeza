//
//  MainEntryPresenterTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/18/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class MainEntryPresenterTests: XCTestCase {
    
    var presenter: MainEntryPresenter!
    
    override func setUpWithError() throws {
        presenter = MainEntryPresenter()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class MainEntryDisplayLogicSpy: MainEntryDisplayLogic {
        
        var displayDataSourceSuccessFulWasCalled = false
        var displayDataSourceErrorFoundWasCalled = false
        var displayDetailSuccessFulWasCalled = false
        var displayDetailErrorFoundWasCalled = false
        var displayFavoriteWasCalled = false
        
        var displayDataSourceSuccessFulViewModel: MainEntry.DataStore.ViewModel.Successful?
        
        func displayDataSourceSuccessFul(viewModel: MainEntry.DataStore.ViewModel.Successful) {
            displayDataSourceSuccessFulWasCalled = true
            displayDataSourceSuccessFulViewModel = viewModel
        }
        
        func displayDataSourceErrorFound(viewModel: MainEntry.DataStore.ViewModel.ErrorFound) {
            displayDataSourceErrorFoundWasCalled = true
        }
        
        func displayDetailSuccessFul(viewModel: MainEntry.Detail.ViewModel.Successful) {
            displayDetailSuccessFulWasCalled = true
        }
        
        func displayDetailErrorFound(viewModel: MainEntry.Detail.ViewModel.ErrorFound) {
            displayDetailErrorFoundWasCalled = true
        }
        
        func displayFavorite(viewModel: MainEntry.Favorite.ViewModel) {
            displayFavoriteWasCalled = true
        }
    }
    
    func testPresentDataSourceWithoutErrorsShouldAskViewControllerToDisplayData() throws {
        let viewController = MainEntryDisplayLogicSpy()
        presenter.viewController = viewController
        let items = [EntryModel(title: "title", author: "author", creation: Date(), thumbnailURL: URL(string: "www.google.com"), commentsCount: 10, url: URL(string: "www.apple.com"), id: "1", isOver18: false)]
        
        presenter.presentDataSource(response: MainEntry.DataStore.Response(items: items, errorMessage: nil, safePreference: false))
        
        XCTAssert(viewController.displayDataSourceSuccessFulWasCalled)
        XCTAssertEqual(viewController.displayDataSourceSuccessFulViewModel?.items.first?.thumbnailImageURL, items.first?.thumbnailURL)
        XCTAssertEqual(viewController.displayDataSourceSuccessFulViewModel?.items.first?.author, items.first?.author)
        XCTAssertEqual(viewController.displayDataSourceSuccessFulViewModel?.items.first?.time, "Now")
        XCTAssertEqual(viewController.displayDataSourceSuccessFulViewModel?.items.first?.title, items.first?.title)
        XCTAssertFalse(viewController.displayDataSourceSuccessFulViewModel?.items.first?.shouldHideContent ?? true)
    }
    
    func testPresentDataSourceShouldAskViewControllerToDisplayHeartImageDisabled() throws {
        let viewController = MainEntryDisplayLogicSpy()
        presenter.viewController = viewController
        let items = [EntryModel(title: "title", author: "author", creation: Date(), thumbnailURL: URL(string: "www.google.com"), commentsCount: 10, url: URL(string: "www.apple.com"), id: "1", isOver18: false, isFavorite: false)]
        
        presenter.presentDataSource(response: MainEntry.DataStore.Response(items: items, errorMessage: nil, safePreference: false))
        
        XCTAssertEqual(viewController.displayDataSourceSuccessFulViewModel?.items.first?.heartImage, UIImage(named: Assets.images.heartDisabled.rawValue))
    }
    
    func testPresentDataSourceShouldAskViewControllerToDisplayHeartImageEnabled() throws {
        let viewController = MainEntryDisplayLogicSpy()
        presenter.viewController = viewController
        let items = [EntryModel(title: "title", author: "author", creation: Date(), thumbnailURL: URL(string: "www.google.com"), commentsCount: 10, url: URL(string: "www.apple.com"), id: "1", isOver18: false, isFavorite: true)]
        
        presenter.presentDataSource(response: MainEntry.DataStore.Response(items: items, errorMessage: nil, safePreference: false))
        
        XCTAssertEqual(viewController.displayDataSourceSuccessFulViewModel?.items.first?.heartImage, UIImage(named: Assets.images.heartEnabled.rawValue))
    }
    
    func testShouldHideContentFirstCase() throws {
        let presenter = MainEntryPresenter()
        
        let result = presenter.shouldHideContent(item: EntryModel(title: "", author: "", creation: Date(), thumbnailURL: nil, commentsCount: 0, url: nil, id: "1", isOver18: true), safePreference: false)
        
        XCTAssert(result)
    }
    
    func testShouldHideContentSecondCase() throws {
        let presenter = MainEntryPresenter()
        
        let result = presenter.shouldHideContent(item: EntryModel(title: "", author: "", creation: Date(), thumbnailURL: nil, commentsCount: 0, url: nil, id: "1", isOver18: false), safePreference: false)
        
        XCTAssertFalse(result)
    }
    
    func testShouldHideContentThirdCase() throws {
        let presenter = MainEntryPresenter()
        
        let result = presenter.shouldHideContent(item: EntryModel(title: "", author: "", creation: Date(), thumbnailURL: nil, commentsCount: 0, url: nil, id: "1", isOver18: true), safePreference: true)
        
        XCTAssertFalse(result)
    }
    
    func testShouldHideContentFourthCase() throws {
        let presenter = MainEntryPresenter()
        
        let result = presenter.shouldHideContent(item: EntryModel(title: "", author: "", creation: Date(), thumbnailURL: nil, commentsCount: 0, url: nil, id: "1", isOver18: false), safePreference: true)
        
        XCTAssertFalse(result)
    }
    
    func testAgeFormatter() {
        let presenter = MainEntryPresenter()
        
        let presentTime = Date()
        
        XCTAssertEqual(presenter.formatTime(date: presentTime), "Now")
        
        let futureTime = Date(timeInterval: 10, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: futureTime), "The future")
        
        let aSecondAgoTime = Date(timeInterval: -1, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: aSecondAgoTime), "A second ago")
        
        let twoSecondsAgoTime = Date(timeInterval: -2, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: twoSecondsAgoTime), "2 seconds ago")
        
        let fiftyNineSecondsAgoTime = Date(timeInterval: -59, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: fiftyNineSecondsAgoTime), "59 seconds ago")
        
        let aMinuteAgoTime = Date(timeInterval: -60, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: aMinuteAgoTime), "A minute ago")
        
        let aMinuteAndHalfAgoTime = Date(timeInterval: -90, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: aMinuteAndHalfAgoTime), "A minute ago")
        
        let twoMinutesAgoTime = Date(timeInterval: -60 * 2, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: twoMinutesAgoTime), "2 minutes ago")
        
        let fiftyNineMinutesAgoTime = Date(timeInterval: -60 * 59, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: fiftyNineMinutesAgoTime), "59 minutes ago")
        
        let anHourAgo = Date(timeInterval: -60 * 60, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: anHourAgo), "An hour ago")
        
        let anHourAndHalfAgo = Date(timeInterval: -90 * 60, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: anHourAndHalfAgo), "An hour ago")
        
        let twoHoursAgo = Date(timeInterval: -2 * 60 * 60, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: twoHoursAgo), "2 hours ago")
        
        let twentyThreeHoursAgo = Date(timeInterval: -23 * 60 * 60, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: twentyThreeHoursAgo), "23 hours ago")
        
        let aDayAgo = Date(timeInterval: -24 * 60 * 60, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: aDayAgo), Localized.Strings.older.rawValue)
        
        let aDayAndHalfAgo = Date(timeInterval: -36 * 60 * 60, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: aDayAndHalfAgo), Localized.Strings.older.rawValue)
        
        let fiveDaysAndHalfAgo = Date(timeInterval: -5 * 24 * 60 * 60, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: fiveDaysAndHalfAgo), Localized.Strings.older.rawValue)
        
        let sixDaysAgo = Date(timeInterval: -6 * 24 * 60 * 60, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: sixDaysAgo), Localized.Strings.older.rawValue)
        
        let tenDaysAgo = Date(timeInterval: -10 * 24 * 60 * 60, since: presentTime)
        XCTAssertEqual(presenter.formatTime(date: tenDaysAgo), Localized.Strings.older.rawValue)
    }
    
    func testPresentDataSourceShouldAskViewControllerToDisplayErrorMessage() throws {
        let viewController = MainEntryDisplayLogicSpy()
        presenter.viewController = viewController
        
        presenter.presentDataSource(response: MainEntry.DataStore.Response(items: [EntryModel](), errorMessage: "error found", safePreference: false))
        
        XCTAssert(viewController.displayDataSourceErrorFoundWasCalled)
    }
    
    func testPresentDetailShouldAskViewControllerToDisplayData() throws {
        let viewController = MainEntryDisplayLogicSpy()
        presenter.viewController = viewController
        let item = EntryModel(title: "title", author: "author", creation: Date(), thumbnailURL: URL(string: "www.google.com"), commentsCount: 10, url: URL(string: "www.apple.com"), id: "1", isOver18: false, isFavorite: false)
        
        presenter.presentDetail(response: MainEntry.Detail.Response(item: item, indexPath: IndexPath(item: 0, section: 0), safePreference: false))
        
        XCTAssert(viewController.displayDetailSuccessFulWasCalled)
    }
    
    func testPresentDetailShouldAskViewControllerToDisplayErrorData() throws {
        let viewController = MainEntryDisplayLogicSpy()
        presenter.viewController = viewController
        let item = EntryModel(title: "title", author: "author", creation: Date(), thumbnailURL: URL(string: "www.google.com"), commentsCount: 10, url: URL(string: "www.apple.com"), id: "1", isOver18: true, isFavorite: false)
        
        presenter.presentDetail(response: MainEntry.Detail.Response(item: item, indexPath: IndexPath(item: 0, section: 0), safePreference: false))
        
        XCTAssert(viewController.displayDetailErrorFoundWasCalled)
    }
    
    func testPresentDetailShouldAskViewControllerToDisplayErrorDataBecauseTheURLIsWrong() throws {
        let viewController = MainEntryDisplayLogicSpy()
        presenter.viewController = viewController
        let item = EntryModel(title: "title", author: "author", creation: Date(), thumbnailURL: URL(string: "www.google.com"), commentsCount: 10, url: URL(string: "jdgsdgfs"), id: "1", isOver18: true, isFavorite: false)
        
        presenter.presentDetail(response: MainEntry.Detail.Response(item: item, indexPath: IndexPath(item: 0, section: 0), safePreference: false))
        
        XCTAssert(viewController.displayDetailErrorFoundWasCalled)
    }
}


