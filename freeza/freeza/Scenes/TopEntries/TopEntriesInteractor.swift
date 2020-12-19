//
//  TopEntriesInteractor.swift
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

class TopEntriesInteractor: MainEntryInteractor {
    
    var apiWorker: APIWorker
    var afterTag: String?
    var favorites = [String]() {
        didSet{
            updateDataSource()
        }
    }
    var indexPathToUpdate: IndexPath?
    
    override init() {
        apiWorker = APIWorker(store: RedditAPI())
        super.init()
    }
    
    deinit {
        userDefaultObserver?.invalidate()
    }
    
    override func requestDataStore(request: MainEntry.DataStore.Request) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.apiWorker.fetchTop(after: self.afterTag) { [weak self] (entriesList, afterTag) in
                self?.afterTag = afterTag
                self?.entriesDataSource += entriesList
                self?.validateInformationWithDB(errorMessage: nil)
            } errorHandler: { [weak self] (message) in
                self?.validateInformationWithDB(errorMessage: message)
            }
        }
    }
    
    override func requestFavorite(request: MainEntry.Favorite.Request) {
        indexPathToUpdate = request.indexPath
        var entry = entriesDataSource[request.indexPath.row]
        if !favorites.contains(entry.id ?? "") {
            entryDBWorker?.insert(entryModel: entry) { [weak self] in
                entry.isFavorite = true
                self?.entriesDataSource[request.indexPath.row] = entry
            } errorHandler: { [weak self] (errorMessage) in
                self?.presentDataSourceWithError(errorMessage: errorMessage)
            }
        } else {
            entryDBWorker?.delete(id: entry.id ?? "") { [weak self] in
                entry.isFavorite = false
                self?.entriesDataSource[request.indexPath.row] = entry
            } errorHandler: { [weak self] (errorMessage) in
                self?.presentDataSourceWithError(errorMessage: errorMessage)
            }
        }
    }
    
    override func updateDataSource() {
        if let indexPathToUpdate = indexPathToUpdate {
            presenter?.presentFavorite(response: MainEntry.Favorite.Response(indexPath: indexPathToUpdate, item: entriesDataSource[indexPathToUpdate.row], safePreference: safeMode))
            self.indexPathToUpdate = nil
        } else {
            presentDataSource(errorMessage: nil)
        }
    }
}

extension TopEntriesInteractor {
    func presentDataSource(errorMessage: String?) {
        entriesDataSource = updateFavoritePropertyInApiList(apiEntries: entriesDataSource, favoritesId: favorites)
        presenter?.presentDataSource(response: MainEntry.DataStore.Response(items: entriesDataSource, errorMessage: errorMessage, safePreference: safeMode))
        indexPathToUpdate = nil
    }
    
    func updateFavoritePropertyInApiList(apiEntries: [EntryModel], favoritesId: [String]) -> [EntryModel] {
        return apiEntries.map({EntryModel(title: $0.title, author: $0.author, creation: $0.creation, thumbnailURL: $0.thumbnailURL, commentsCount: $0.commentsCount, url: $0.url, id: $0.id, isOver18: $0.isOver18, isFavorite: favoritesId.contains($0.id ?? ""))})
    }
    
    func startListeningDBChanges() {
        entryDBWorker?.fetchAll(withObserver: true) {[weak self] (favoritesEnties) in
            self?.favorites = favoritesEnties.map({$0.id ?? ""})
        } errorHandler: { [weak self] (errorMessage) in
            self?.presentDataSourceWithError(errorMessage: errorMessage)
        }
    }
    
    func validateInformationWithDB(errorMessage: String?) {
        if entryDBWorker == nil {
            //start observing a realm instace requires to run it in the main thread
            DispatchQueueHelper.executeInMainThread { [weak self] in
                self?.entryDBWorker = EntryWorker(store: EntryRealmStore())
                self?.startListeningDBChanges()
            }
        } else {
            presentDataSource(errorMessage: errorMessage)
        }
    }
}
