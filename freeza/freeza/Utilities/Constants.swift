//
//  Constants.swift
//  freeza
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import Foundation


struct Storyboard {
    enum ReferenceName: String {
        case settings = "Settings"
        case favorites = "Favorites"
    }
}

struct ViewControllerReference {
    enum Name: String {
        case settingsViewController = "SettingsViewController"
        case favoritesViewController = "FavoritesViewController"
    }
}

struct User {
    enum Defaults: String {
        case safe
        case realmEncryptionKey
    }
}

struct CustomCell {
    enum Name: String {
        case settingsCustomTableViewCell = "SettingsCustomTableViewCell"
        case entryTableCustomTableViewCell = "EntryTableCustomTableViewCell"
    }
}

struct Localized {
    enum Strings: String {
        case safe = "SAFE"
        case older = "Older"
    }
}

struct Assets {
    enum images: String {
        case heartDisabled
        case heartEnabled
    }
}
