//
//  ContainerManager.swift
//  NoFeed
//
//  Created by Vova Seuruk on 9/22/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import Foundation

class ContainerManager: ContainerManagerProtocol {
    
    init() {
        if !modelExists(with: .empty) {
            addModel(with: .empty)
        }
    }
    
    private let feedsKey = "feeds"
    
    private let sharedUserDefaults: UserDefaults = {
        guard let userDefaults = UserDefaults(suiteName: "group.insider.nofeed") else {
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
    
    //MARK: ContainerManagerProtocol
    
    func blockerIndetifier(for value: String) -> BlockerIdentifier? {
        switch value {
        case BlockerIdentifier.facebook.rawValue:
            return .facebook
        case BlockerIdentifier.instagram.rawValue:
            return .instagram
        case BlockerIdentifier.twitter.rawValue:
            return .twitter
        case BlockerIdentifier.vk.rawValue:
            return .vk
        case BlockerIdentifier.empty.rawValue:
            return .empty
        default:
            return nil
        }
    }
    
    var models: [BlockerIdentifier] {
        var identifiers: [BlockerIdentifier] = []
        
        guard feedsArray.count != 0 else {
            return identifiers
        }
        
        for identifier in feedsArray {
            if let blockerId = blockerIndetifier(for: identifier) {
                identifiers.append(blockerId)
            }
        }
        
        return identifiers
    }
    
    func modelExists(with identifier: BlockerIdentifier) -> Bool {
        let modelIndex = feedsArray.index(where: { $0 == identifier.rawValue })
        return modelIndex != nil
    }
    
    func addModel(with identifier: BlockerIdentifier) {
        var updatedFeeds = feedsArray
        updatedFeeds.append(identifier.rawValue)
        setFeedsArray(with: updatedFeeds)
    }

    func removeModel(with identifier: BlockerIdentifier) {
        guard let identifierIndex = feedsArray.index(where: { $0 == identifier.rawValue }) else {
            return
        }
        var updatedFeeds = feedsArray
        updatedFeeds.remove(at: identifierIndex)
        setFeedsArray(with: updatedFeeds)
    }
    
}
