//
//  ContainerManager.swift
//  NoFeed
//
//  Created by Vova Seuruk on 9/22/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import Foundation

class ContainerManager {
    
    init() {
        createModelIfNeeded()
    }
    
    func addModel(with identifier: String) {

    }

    func removeModel(with identifier: String) {

    }
    
    private let arrayKey = "feeds"
    
    private let sharedUserDefaults: UserDefaults = {
        let groupName = "group.nofeed"
        guard let userDefaults = UserDefaults(suiteName: groupName) else {
            fatalError("No shared container with groupName == \(groupName) detected.")
        }
        return userDefaults
    }()
    
    
    private var feedsArray: [String]? {
        return sharedUserDefaults.array(forKey: arrayKey) as? [String]
    }
    
    private var isFeedsArrayExists: Bool {
        return feedsArray != nil
    }
    
    private func setFeedsArray(with value: [String]) {
        sharedUserDefaults.set(value, forKey: arrayKey)
    }
    
    private func createModelIfNeeded() {
        guard isFeedsArrayExists else {
            return
        }
        setFeedsArray(with: [])
    }
    
    
}
