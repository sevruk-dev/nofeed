//
//  AppCoordinator.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/22/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

class AppCoordinator {
    
    private let appNavigator: AppNavigator
    
    init(with appNavigator: AppNavigator) {
        self.appNavigator = appNavigator
    }
    
    func coordinate() {
        appNavigator.navigate(to: .onBoarding)
    }
    
}
