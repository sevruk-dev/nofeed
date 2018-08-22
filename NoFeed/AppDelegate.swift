//
//  AppDelegate.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/4/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let appNavigator = AppNavigator(with: navigationController)
        appCoordinator = AppCoordinator(with: appNavigator)
        appCoordinator?.coordinate()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        return true
    }

}

