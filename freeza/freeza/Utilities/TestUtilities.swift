//
//  TestUtilities.swift
//  freeza
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//
// This file contains some utilities for unit testing

import Foundation
import UIKit



struct TestUtilities {
    static func loadView(window: inout UIWindow, viewController: UIViewController) {
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
}

class TableViewSpy: UITableView {
    
    var reloadDataWasCalled = false
    var registerForCellReuseIdentifierWasCalled = false
    
    override func reloadData() {
        reloadDataWasCalled = true
    }
    
    override func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        registerForCellReuseIdentifierWasCalled = true
    }
}
