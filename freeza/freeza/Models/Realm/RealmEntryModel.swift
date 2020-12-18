//
//  RealmEntryModel.swift
//  freeza
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import RealmSwift

class RealmEntryModel: Object {
    
    @objc dynamic var id = ""
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
    
    convenience init(entryModel: EntryModel) {
        self.init()
        id = entryModel.id ?? ""
        isOver18 = entryModel.isOver18 ?? false
        title = entryModel.title ?? ""
        author = entryModel.author ?? ""
        thumbnailURL = entryModel.thumbnailURL?.absoluteString ?? ""
        url = entryModel.url?.absoluteString ?? ""
        createAt = entryModel.creation ?? Date()
        commentsCount = entryModel.commentsCount ?? 0
    }
}

extension RealmEntryModel {
    func toEntryModel() -> EntryModel {
        return EntryModel(title: title, author: author, creation: createAt, thumbnailURL: URL(string: thumbnailURL), commentsCount: commentsCount, url: URL(string: url), id: id, isOver18: isOver18)
    }
}
