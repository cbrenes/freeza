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
        case topEntry = "TopEntry"
        case main = "Main"
        case urlDetail = "URLDetail"
    }
}

struct ViewControllerReference {
    enum Name: String {
        case settingsViewController = "SettingsViewController"
        case favoritesViewController = "FavoritesViewController"
        case topEntriesViewController = "TopEntriesViewController"
        case urlDetailViewController = "URLDetailViewController"
    }
}

struct User {
    enum Defaults: String {
        case safe
        case realmEncryptionKey
        case isRunningTargetTests
    }
}

struct CustomCell {
    enum Name: String {
        case settingsCustomTableViewCell = "SettingsCustomTableViewCell"
        case entryCustomTableViewCell = "EntryCustomTableViewCell"
    }
}

struct Localized {
    enum Strings: String {
        case safe = "Safe (NSFW disabled)"
        case older = "Older"
        case issuesWiththeDB = "Issues with the Database found"
        case ok = "ok"
        case weDontHaveElementsToShow = "We don't have elements to show"
    }
}

struct Assets {
    enum images: String {
        case heartDisabled
        case heartEnabled
    }
}
