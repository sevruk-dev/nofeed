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
    
    init(with appNavigator: AppNavigator) {
        self.appNavigator = appNavigator
    }
    
    func coordinate() {
        SFContentBlockerManager.getStateOfContentBlocker(withIdentifier: "com.svg.NoFeed.contentBlocker") { [weak self] (state, error) in
            DispatchQueue.main.async {
                let destination: AppNavigator.Destination = state?.isEnabled == true ? .onBoarding : .safariSetup
                self?.appNavigator.navigate(to: destination)
            }
        }
    }
    
}
