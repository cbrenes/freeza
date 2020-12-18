//
//  LocalQuickStorageWorkerTests.swift
//  freezaTests
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import XCTest
@testable import freeza

class LocalQuickStorageWorkerTests: XCTestCase {
    
    var worker: LocalQuickStorageWorker!

    override func setUpWithError() throws {
        worker = LocalQuickStorageWorker(store: UserDefaultsService())
    }

    override func tearDownWithError() throws {
        worker.clear(key: User.Defaults.safe.rawValue)
    }

    func testWriteAndRetrieveValue() throws {
        XCTAssertNil(worker.get(key: User.Defaults.safe.rawValue))
        
        worker.save(value: true, key: User.Defaults.safe.rawValue)
        
        XCTAssert(worker.get(key: User.Defaults.safe.rawValue) as? Bool ?? false)
    }
    
    func testSetTrueValue() {
        worker.save(value: true, key: User.Defaults.safe.rawValue)
        
        XCTAssert(worker.get(key: User.Defaults.safe.rawValue) as? Bool ?? false)
    }
    
    func testSetFalseValue() {
        worker.save(value: false, key: User.Defaults.safe.rawValue)
        
        XCTAssertFalse(worker.get(key: User.Defaults.safe.rawValue) as? Bool ?? true)
    }
    
}
