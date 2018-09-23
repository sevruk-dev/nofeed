//
//  ContainerManager.swift
//  NoFeed
//
//  Created by Vova Seuruk on 9/22/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import Foundation

class ContainerManager: ContainerManagerProtocol {
    
    private let feedsKey = "feeds"
    
    private let sharedUserDefaults: UserDefaults = {
        guard let userDefaults = UserDefaults(suiteName: "group.nofeed") else {
            fatalError("No shared container detected.")
        }
        return userDefaults
    }()
    
    private var feedsArray: [String] {
        return sharedUserDefaults.array(forKey: feedsKey) as? [String] ?? []
    }
    
    private func setFeedsArray(with value: [String]) {
        sharedUserDefaults.set(value, forKey: feedsKey)
    }
    
    //MARK: public interface
    
    func addModel(with identifier: String) {
        var updatedFeeds = feedsArray
        updatedFeeds.append(identifier)
        setFeedsArray(with: updatedFeeds)
    }

    func removeModel(with identifier: String) {
        guard let identifierIndex = feedsArray.index(where: { $0 == identifier }) else {
            return
        }
        var updatedFeeds = feedsArray
        updatedFeeds.remove(at: identifierIndex)
        setFeedsArray(with: updatedFeeds)
    }
    
}
