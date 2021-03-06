//
//  FavoritesInteractor.swift
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


class FavoritesInteractor: MainEntryInteractor {
    
    override init() {
        super.init()
        entryDBWorker = EntryWorker(store: EntryRealmStore())
    }
    
    override func requestDataStore(request: MainEntry.DataStore.Request) {
        startObservingDBChanges()
    }
    
    override  func requestFavorite(request: MainEntry.Favorite.Request) {
        let entry = entriesDataSource[request.indexPath.row]
        entryDBWorker?.delete(id: entry.id ?? "") {
        } errorHandler: { [weak self] (errorMessage) in
            self?.presentDataSourceWithError(errorMessage: errorMessage)
        }
    }
    
    override func updateDataSource() {
        presenter?.presentDataSource(response: MainEntry.DataStore.Response(items: entriesDataSource, errorMessage: nil, safePreference: safeMode))
    }
    
    func startObservingDBChanges() {
        entryDBWorker?.fetchAll(withObserver: true) { [weak self] (entries) in
            self?.entriesDataSource = entries
            self?.presenter?.presentDataSource(response: MainEntry.DataStore.Response(items: self?.entriesDataSource ?? [EntryModel](), errorMessage: nil, safePreference: self?.safeMode ?? false))
        } errorHandler: { [weak self] (errorMessage) in
            self?.presenter?.presentDataSource(response: MainEntry.DataStore.Response(items: [EntryModel](), errorMessage: errorMessage, safePreference: self?.safeMode ?? false))
        }
    }
}
