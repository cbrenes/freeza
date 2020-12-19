//
//  EntryWorkerTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class EntryWorkerTests: XCTestCase {
    
    var worker: EntryWorker!

    override func setUpWithError() throws {
        RealmHelper.deleteAllDB()
        worker = EntryWorker(store: EntryRealmStore())
    }

    override func tearDownWithError() throws {
        RealmHelper.deleteAllDB()
    }

    func testInsertObjectIntoTheDB() throws {
        let expect = expectation(description: "DB operations")
        let entry = EntryModel(title: "1", author: "2", creation: Date(), thumbnailURL: URL(string: "www.google.com"), commentsCount: 10, url: URL(string: "www.apple.com"), id: "2", isOver18: false)
        var entryRetrievedFromDB: EntryModel?
        hasElementsStored { (result) in
            if result {
                expect.fulfill()
            }
            self.worker.insert(entryModel: entry) {
                self.worker.fetchAll(withObserver: false) { (entriesFromDB) in
                    entryRetrievedFromDB = entriesFromDB.first
                    expect.fulfill()
                } errorHandler: { (_) in
                    expect.fulfill()
                }
            } errorHandler: { (_) in
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(entry.title, entryRetrievedFromDB?.title)
        XCTAssertEqual(entry.author, entryRetrievedFromDB?.author)
        XCTAssertEqual(entry.creation, entryRetrievedFromDB?.creation)
        XCTAssertEqual(entry.thumbnailURL, entryRetrievedFromDB?.thumbnailURL)
        XCTAssertEqual(entry.commentsCount, entryRetrievedFromDB?.commentsCount)
        XCTAssertEqual(entry.url, entryRetrievedFromDB?.url)
        XCTAssertEqual(entry.id, entryRetrievedFromDB?.id)
        XCTAssertEqual(entry.isOver18, entryRetrievedFromDB?.isOver18)
    }
    
    func testDeleteObjectIntoTheDB() throws {
        let expect = expectation(description: "DB operations")
        let entry = EntryModel(title: "1", author: "2", creation: Date(), thumbnailURL: URL(string: "www.google.com"), commentsCount: 10, url: URL(string: "www.apple.com"), id: "2", isOver18: false)
        var objectWasDeletecCorrectly = false
        hasElementsStored { (result) in
            if result {
                expect.fulfill()
            }
            self.worker.insert(entryModel: entry) {
                self.worker.delete(id: entry.id ?? "90") {
                    self.hasElementsStored { (numberOfElements) in
                        objectWasDeletecCorrectly = !numberOfElements
                        expect.fulfill()
                    }
                } errorHandler: { (_) in
                    expect.fulfill()
                }

            } errorHandler: { (_) in
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssert(objectWasDeletecCorrectly)
    }
    
    private func hasElementsStored(completionHandler: @escaping(_ value: Bool) -> ()) {
        worker.fetchAll(withObserver: false) { (elements) in
            completionHandler(!elements.isEmpty)
        } errorHandler: { (_) in
            completionHandler(false)
        }
    }
}
