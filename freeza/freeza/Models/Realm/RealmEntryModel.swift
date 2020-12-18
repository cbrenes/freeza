//
//  RealmEntryModel.swift
//  freeza
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import RealmSwift

class RealmEntryModel: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var isOver18: Bool = false
    @objc dynamic var title = ""
    @objc dynamic var author = ""
    @objc dynamic var thumbnailURL = ""
    @objc dynamic var url = ""
    @objc dynamic var createAt: Date = Date()
    @objc dynamic var commentsCount: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["id", "isOver18"]
    }
}
