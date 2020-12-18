//
//  RealmHelper.swift
//  freeza
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    static var realmInstance: Realm? {
        let config = Realm.Configuration(encryptionKey: RealmHelper.realmKey)
        let realm = try? Realm(configuration: config)
        return realm
    }
    
    //This method must be used only for the unit tests target, because it doesn't have error handle
    class func deleteAllDB() {
        guard let realm = RealmHelper.realmInstance else {
            return
        }
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    // I am encrypting the realm file. The key is stored in userDefaults
    private static var realmKey: Data {
        var key = Data(count: 64)
        let localStorageWorker = LocalQuickStorageWorker(localQuickStorageStore: UserDefaultsService())
        guard let existingKey = localStorageWorker.get(key: User.Defaults.realmEncryptionKey.rawValue) as? Data else {
            // Generate a random encryption key
            key.withUnsafeMutableBytes {(rawMutableBufferPointer) in
                let bufferPointer = rawMutableBufferPointer.bindMemory(to: UInt8.self)
                if let address = bufferPointer.baseAddress {
                    _ = SecRandomCopyBytes(kSecRandomDefault, 64, address)
                }
            }
            localStorageWorker.save(value: key, key: User.Defaults.realmEncryptionKey.rawValue)
            return key
        }
        key = existingKey
        return key
    }
}
