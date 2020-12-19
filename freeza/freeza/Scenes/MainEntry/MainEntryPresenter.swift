//
//  MainEntryPresenter.swift
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

protocol MainEntryPresentationLogic {
    func presentDataSource(response: MainEntry.DataStore.Response)
    func presentDetail(response: MainEntry.Detail.Response)
    func presentFavorite(response: MainEntry.Favorite.Response)
}

class MainEntryPresenter: MainEntryPresentationLogic {
    weak var viewController: MainEntryDisplayLogic?
    
    // MARK: Do something
    
    func presentDataSource(response: MainEntry.DataStore.Response) {
        guard let errorMessage = response.errorMessage else {
            let itemsToDisplay = response.items.map({MainEntry.ItemToDisplay(thumbnailImageURL: $0.thumbnailURL, author: $0.author ?? "", commentCount: " \($0.commentsCount ?? 0) ", time: formatTime(date: $0.creation ?? Date()), title: $0.title ?? "", heartImage: MainEntryPresenter.getHeartImage(isFavorite: $0.isFavorite), shouldHideContent: shouldHideContent(item: $0, safePreference: response.safePreference))})
            viewController?.displayDataSourceSuccessFul(viewModel: MainEntry.DataStore.ViewModel.Successful(items: itemsToDisplay))
            return
        }
        viewController?.displayDataSourceErrorFound(viewModel: MainEntry.DataStore.ViewModel.ErrorFound(message: errorMessage))
    }
    
    func presentDetail(response: MainEntry.Detail.Response) {
        if shouldHideContent(item: response.item, safePreference: response.safePreference) {
            viewController?.displayDetailErrorFound(viewModel: MainEntry.Detail.ViewModel.ErrorFound(indexPath: response.indexPath))
            return
        }
        guard let _ = response.item.url else {
            viewController?.displayDetailErrorFound(viewModel: MainEntry.Detail.ViewModel.ErrorFound(indexPath: response.indexPath))
            return
        }
        viewController?.displayDetailSuccessFul(viewModel: MainEntry.Detail.ViewModel.Successful(item: response.item))
    }
    
    func presentFavorite(response: MainEntry.Favorite.Response) {
        let item = MainEntry.ItemToDisplay(thumbnailImageURL: response.item.thumbnailURL, author: response.item.author ?? "", commentCount: " \(response.item.commentsCount ?? 0) ", time: formatTime(date: response.item.creation ?? Date()), title: response.item.title ?? "", heartImage: MainEntryPresenter.getHeartImage(isFavorite: response.item.isFavorite), shouldHideContent: shouldHideContent(item: response.item, safePreference: response.safePreference))
        viewController?.displayFavorite(viewModel: MainEntry.Favorite.ViewModel(indexPath: response.indexPath, item: item))
    }
    
    class func getHeartImage(isFavorite: Bool) -> UIImage? {
        return isFavorite ? UIImage(named: Assets.images.heartEnabled.rawValue) :  UIImage(named: Assets.images.heartDisabled.rawValue)
    }
    
    func shouldHideContent(item: EntryModel, safePreference: Bool) -> Bool {
        if let isOver18 = item.isOver18 {
            if isOver18 && !safePreference {
                return true
            }
            if !isOver18 {
                return false
            }
        }
        return false
    }
    
    func formatTime(date: Date) -> String {
        let secondsAgo = Int(Date().timeIntervalSince(date))
        if secondsAgo < 0 {
            //Not expecting this to happen in this app, but must be prepared.
            return "The future"
            
        } else if secondsAgo == 0 {
            return "Now"
            
        } else if secondsAgo == 1 {
            return "A second ago"
            
        } else if secondsAgo < 60 {
            return "\(secondsAgo) seconds ago"
            
        } else if secondsAgo < 2 * 60 {
            return "A minute ago"
            
        } else if secondsAgo < 60 * 60 {
            return "\(secondsAgo / 60) minutes ago"
            
        } else if secondsAgo < 2 * 60 * 60 {
            return "An hour ago"
            
        } else if secondsAgo < 24 * 60 * 60 {
            return "\(secondsAgo / (60 * 60)) hours ago"
            
        } else {
            return Localized.Strings.older.rawValue
        }
    }
}
