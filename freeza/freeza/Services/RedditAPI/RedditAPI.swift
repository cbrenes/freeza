//
//  RedditAPI.swift
//  freeza
//
//  Created by Cesar Brenes on 12/18/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import Foundation

class RedditAPI: APIStoreProtocol {
    
    private let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func fetchTop(after afterTag: String?, completionHandler: @escaping (_ entries: [EntryModel], _ afterTag: String?) -> (), errorHandler: @escaping (_ message: String) -> ()) {
        var requestURLString = "https://www.reddit.com/top.json?limit=50"
        if let afterTag = afterTag {
            requestURLString.append("&after=\(afterTag)")
        }
        guard let requestURL = URL(string: requestURLString) else {
            errorHandler("An error occurred formatting the fetch URL: \(requestURLString)")
            return
        }
        let request = URLRequest(url: requestURL)
        fetch(request: request, completionHandler: completionHandler, errorHandler: errorHandler)
    }
    
    private func fetch(request: URLRequest, completionHandler:@escaping (_ entries: [EntryModel], _ afterTag: String?) -> (), errorHandler: @escaping (_ message: String) -> ()) {
        let dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
            guard let _ = response else {
                errorHandler("Please check your internet connection. Server may be down.")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                errorHandler("Invalid server response type.")
                return
            }
            let statusCode = httpResponse.statusCode
            guard statusCode == 200 else {
                errorHandler("Invalid response code: \(statusCode)")
                return
            }
            guard let data = data else {
                errorHandler("Invalid response Data (empty).")
                return
            }
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] else {
                    errorHandler("An error occurrred parsing the response.")
                    return
                }
                self.mapResponse(response: dictionary, completionHandler: completionHandler, errorHandler: errorHandler)
            } catch {
                errorHandler("An error occurrred parsing the response.")
            }
        }
        dataTask.resume()
    }
    
    private func mapResponse(response: [String: Any]?, completionHandler:@escaping (_ entries: [EntryModel], _ afterTag: String?) -> (), errorHandler: @escaping (_ message: String) -> ()) {
        guard let data = response?["data"] as? [String: AnyObject],
              let children = data["children"] as? [[String:AnyObject]] else {
            errorHandler("Invalid responseDictionary.")
            return
        }
        let afterTag = data["after"] as? String
        let newEntries = children.map { dictionary -> EntryModel in
            let dataDictionary = dictionary["data"] as? [String: AnyObject] ?? [String: AnyObject]()
            return EntryModel(withDictionary: dataDictionary)
        }
        completionHandler(newEntries, afterTag)
    }
}
