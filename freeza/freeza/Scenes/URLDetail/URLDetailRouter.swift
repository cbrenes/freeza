//
//  URLDetailRouter.swift
//  freeza
//
//  Created by Cesar Brenes on 12/18/20.
//  Copyright (c) 2020 Zerously. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit


protocol URLDetailDataPassing {
    var dataStore: URLDetailDataStore? { get set}
}

class URLDetailRouter: NSObject, URLDetailDataPassing {
    weak var viewController: URLDetailViewController?
    var dataStore: URLDetailDataStore?
}
