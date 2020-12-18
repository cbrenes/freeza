//
//  RedditMockAPI.swift
//  freeza
//
//  Created by Cesar Brenes on 12/18/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import Foundation

//This class allows to run the app without need to call the API, it's important for unit testing

class RedditMockAPI: APIStoreProtocol {
    func fetchTop(after afterTag: String?, completionHandler: @escaping ([EntryModel], String?) -> (), errorHandler: @escaping (String) -> ()) {
        let items = [EntryModel(title: "I hide my diamonds here", author: "vladgrinch", creation: Date(), thumbnailURL: URL(string: "https://b.thumbs.redditmedia.com/Lusm4RMZ57GwvdcoRoA7_QxClVpWSqjxjmI7bEdyHTA.jpg"), commentsCount: 10, url: URL(string: "https://i.redd.it/nq6v157x3t561.png"
        ), id: 1, isOver18: true), EntryModel(title: "Creating special moments within family", author: "sreenath95", creation: Date(), thumbnailURL: URL(string: "https://b.thumbs.redditmedia.com/MdGn8r4j5IE1Zfe6CT849mK3705_tIV_ek5J7FJaXGI.jpg"), commentsCount: 20, url: URL(string: "https://v.redd.it/9mbj8vqf0t561"
        ), id: 2, isOver18: false)]
        completionHandler(items, nil)
    }
}
