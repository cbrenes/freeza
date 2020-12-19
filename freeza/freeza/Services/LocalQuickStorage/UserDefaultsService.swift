//
//  UserDefaultsService.swift
//  freeza
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import Foundation

class UserDefaultsService: LocalQuickStorageProtocol {
    func save(value: Any, key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    func get(key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    func clear(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
