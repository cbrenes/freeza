//
//  FavoritesViewController.swift
//  freeza
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright (c) 2020 Zerously. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class FavoritesViewController: MainEntryViewController {
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup(businessLogic: MainEntryStoreInteractor(businessLogic: FavoritesInteractor()))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup(businessLogic: MainEntryStoreInteractor(businessLogic: FavoritesInteractor()))
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func displayDataSourceErrorFound(viewModel: MainEntry.DataStore.ViewModel.ErrorFound) {
        super.displayDataSourceErrorFound(viewModel: viewModel)
        DispatchQueueHelper.executeInMainThread { [weak self] in
            self?.items.removeAll()
            self?.tableView?.reloadData()
        }
    }
}
