//
//  UserDefaults+Custom.swift
//  freeza
//
//  Created by Cesar Brenes on 12/18/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import Foundation

extension UserDefaults {
    @objc dynamic var safe: Bool {
        return bool(forKey: User.Defaults.safe.rawValue)
    }
}
