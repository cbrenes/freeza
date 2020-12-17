//
//  TestUtilities.swift
//  freeza
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import Foundation
import UIKit


struct TestUtilities {
    static func loadView(window: inout UIWindow, viewController: UIViewController) {
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
}
