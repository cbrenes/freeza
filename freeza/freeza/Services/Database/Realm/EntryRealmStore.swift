//
//  EntryRealmStore.swift
//  freeza
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import Foundation
import RealmSwift


class EntryRealmStore: EntryStoreProtocol {
    
    private var notificationToken: NotificationToken?
    
    deinit {
        notificationToken?.invalidate()
    }
    
    func insert(entryModel: EntryModel, completionHandler: @escaping () -> (), errorHandler: @escaping (String) -> ()) {
        autoreleasepool {
            do {
                guard let realm = RealmHelper.realmInstance else {
                    errorHandler("Error trying to create the Realm Instace")
                    return
                }
                let entryRealmObject = RealmEntryModel(entryModel: entryModel)
                try realm.write {
                    realm.add(entryRealmObject, update: .all)
                }
                completionHandler()
            } catch {
                errorHandler("Error trying to insert a new element in Realm DB")
            }
        }
    }
    
    func fetchAll(withObserver: Bool, completionHandler: @escaping ([EntryModel]) -> (), errorHandler: @escaping (String) -> ()) {
        autoreleasepool {
            guard let realm = RealmHelper.realmInstance else {
                errorHandler("Error trying to create the Realm Instace")
                return
            }
            let results = realm.objects(RealmEntryModel.self)
            if notificationToken == nil && withObserver {
                
            }
            completionHandler(results.map({$0.toEntryModel()}))
        }
    }
    
    func delete(id: Int, completionHandler: @escaping () -> (), errorHandler: @escaping (String) -> ()) {
        autoreleasepool {
            do {
                guard let realm = RealmHelper.realmInstance else {
                    errorHandler("Error trying to create the Realm Instace")
                    return
                }
                let predicate = NSPredicate(format: "id = %d", id)
                if let elementToDelete = realm.objects(RealmEntryModel.self).filter(predicate).first {
                    try realm.write {
                        realm.delete(elementToDelete)
                    }
                    completionHandler()
                } else {
                    errorHandler("Delete failed, the element couldn't be found")
                }
            } catch {
                errorHandler("Error trying to delete the element with the id \(id)")
            }
        }
    }
    
    private func fetchAllObserver(results: Results<RealmEntryModel>, completionHandler: @escaping ([EntryModel]) -> (), errorHandler: @escaping (String) -> ()) {
        notificationToken?.invalidate()
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self?.fetchAll(withObserver: true, completionHandler: completionHandler, errorHandler: errorHandler)
            case .update:
                self?.fetchAll(withObserver: true, completionHandler: completionHandler, errorHandler: errorHandler)
            case .error:
                errorHandler("An error occuring observing the fetch entries in Realm")
            }
        }
    }
}
