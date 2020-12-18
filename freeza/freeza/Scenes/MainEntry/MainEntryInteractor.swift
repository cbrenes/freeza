//
//  MainEntryInteractor.swift
//  freeza
//
//  Created by Cesar Brenes on 12/18/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import Foundation

class MainEntryInteractor: MainEntryBusinessLogic, MainEntryDataStore {
    var presenter: MainEntryPresentationLogic?
    
    var entriesDataSource = [EntryModel]()
    var entryDBWorker: EntryWorker?
    var userDefaultObserver: NSKeyValueObservation?
    var safeMode: Bool = LocalQuickStorageWorker(store: UserDefaultsService()).get(key: User.Defaults.safe.rawValue) as? Bool ?? false {
        didSet {
            updateDataSource()
        }
    }
    
    init() {
        if !TestUtilities.isRunningTests() { //This observer shouldn't be initialized when the unit tests are running
            userDefaultObserver = UserDefaults.standard.observe(\.safe, options: [.initial, .new], changeHandler: {[weak self] (defaults, change) in
                if let newValue = change.newValue {
                    self?.safeMode = newValue
                }
            })
        }
    }
    
    deinit {
        userDefaultObserver?.invalidate()
    }
    
    func requestDataStore(request: MainEntry.DataStore.Request) {
        //This method will be override per the child
    }
    
    func requestDetail(request: MainEntry.Detail.Request) {
        presenter?.presentDetail(response: MainEntry.Detail.Response(item: entriesDataSource[request.indexPath.row], indexPath: request.indexPath, safePreference: safeMode))
    }
    
    func requestFavorite(request: MainEntry.Favorite.Request) {
        //This method will be override per the child
    }
    
    func updateDataSource() {
        //This method will be override per the child
    }
    
    func presentDataSourceWithError(errorMessage: String) {
        presenter?.presentDataSource(response: MainEntry.DataStore.Response(items: [EntryModel](), errorMessage: errorMessage, safePreference: safeMode))
    }
}
