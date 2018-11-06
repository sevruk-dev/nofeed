//
//  AppCoordinator.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/22/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import SafariServices

class AppCoordinator {
    
    private let appNavigator: AppNavigator
    private let configuration = Configuration.shared
    
    init(with appNavigator: AppNavigator) {
        self.appNavigator = appNavigator
    }
    
    func coordinate() {
        SFContentBlockerManager.getStateOfContentBlocker(withIdentifier: "io.insider.apps.nofeed.contentBlocker") { [weak self] (state, error) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                let onboardingCompleted = self.configuration.onboardingCompleted
                let destination: AppNavigator.Destination
                
                if let state = state, state.isEnabled {
                    destination = onboardingCompleted ? .main : .onboarding
                } else {
                    destination = .safariSetup
                }
                
                self.appNavigator.navigate(to: destination)
            }
        }
    }
    
}
