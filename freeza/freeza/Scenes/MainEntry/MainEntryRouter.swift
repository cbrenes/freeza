//
//  MainEntryRouter.swift
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

protocol MainEntryRoutingLogic {
    func goToDetailViewController(item: EntryModel)
}

class MainEntryRouter: NSObject, MainEntryRoutingLogic {
    weak var viewController: MainEntryViewController?
    
    func goToDetailViewController(item: EntryModel) {
        let storyboard = UIStoryboard(name: Storyboard.ReferenceName.urlDetail.rawValue, bundle: nil)
        if let urlViewController = storyboard.instantiateViewController(withIdentifier: ViewControllerReference.Name.urlDetailViewController.rawValue) as? URLDetailViewController {
            urlViewController.router?.dataStore?.item = item
            viewController?.navigationController?.pushViewController(urlViewController, animated: true)
        }
    }
}
