//
//  LocalQuickStorageWorker.swift
//  freeza
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import Foundation

enum StorageType {
    case bool
}

protocol LocalQuickStorageProtocol {
    func save(value: Any, key: String)
    func get(key: String) -> Any?
    func clear(key: String)
}

class LocalQuickStorageWorker {
    
    var store: LocalQuickStorageProtocol
    
    init(store: LocalQuickStorageProtocol) {
        self.store = store
    }
    
    func save(value: Any, key: String) {
        store.save(value: value, key: key)
    }
    
    func get(key: String) -> Any? {
        return store.get(key: key)
    }
    
    func clear(key: String) {
        store.clear(key: key)
    }
}
