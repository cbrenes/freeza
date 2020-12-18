//
//  SettingsInteractor.swift
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

protocol SettingsBusinessLogic {
    func requestDataSource(request: Settings.DataSource.Request)
    func requestSetValue(request: Settings.SetValue.Request)
}

protocol SettingsDataStore {
    //var name: String { get set }
}

class SettingsInteractor: SettingsBusinessLogic, SettingsDataStore {
    var presenter: SettingsPresentationLogic?
    var worker = SettingsWorker()
    var localQuickStorageWorker: LocalQuickStorageWorker
    
    init() {
        localQuickStorageWorker = LocalQuickStorageWorker(store: UserDefaultsService())
    }
    
    var items = [Settings.Item]()
    
    func requestDataSource(request: Settings.DataSource.Request) {
        if items.isEmpty {
            items = worker.createDataSource(worker: localQuickStorageWorker)
        }
        presenter?.presentDataSource(response: Settings.DataSource.Response(items: items))
    }
    
    func requestSetValue(request: Settings.SetValue.Request) {
        var item = items[request.indexPath.row]
        item.value = request.value
        items[request.indexPath.row] = item
        switch item.type {
        case .safe:
            localQuickStorageWorker.save(value: request.value, key: User.Defaults.safe.rawValue)
        }
    }
}
