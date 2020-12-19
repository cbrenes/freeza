//
//  URLDetailModels.swift
//  freeza
//
//  Created by Cesar Brenes on 12/18/20.
//  Copyright (c) 2020 Zerously. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum URLDetail {
    // MARK: Use cases
    enum UIInfo {
        struct Request {
        }
        struct Response {
            var item: EntryModel
        }
        struct ViewModel {
            var url: URL
            var image: UIImage?
        }
    }
    
    enum FavoriteAction {
        struct Request {
        }
        struct Response {
            var item: EntryModel
            var errorFound: String?
        }
        struct ViewModel {
            struct Successful {
                var image: UIImage?
            }
            struct ErrorFound {
                var alertController: UIAlertController
            }
        }
    }
}
