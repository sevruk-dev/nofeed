//
//  Configuration.swift
//  NoFeed
//
//  Created by Vova Seuruk on 11/4/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import Foundation

class Configuration {
    
    private init() {}
    
    static let shared: Configuration = Configuration()
    
    private let onboardingCompletedKey = "OnboardingCompleted"
    
    var onboardingCompleted: Bool {
        return UserDefaults.standard.bool(forKey: onboardingCompletedKey)
    }
    
    func setOnboardingCompleted(_ completed: Bool) {
        UserDefaults.standard.set(completed, forKey: onboardingCompletedKey)
    }
    
}
