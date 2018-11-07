//
//  AppDelegate.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/4/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit
import Firebase
import SafariServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    private let extensionId = "io.insider.apps.nofeed.contentBlocker"
    private var isEnteringForeground: Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = NavigationController()
        let appNavigator = AppNavigator(with: navigationController)
        appCoordinator = AppCoordinator(with: appNavigator)
        appCoordinator?.coordinate()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        reloadContentBlocker()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if isEnteringForeground {
            appCoordinator?.coordinate()
            isEnteringForeground = false
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        isEnteringForeground = true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        reloadContentBlocker()
    }
    
    private func reloadContentBlocker() {
        SFContentBlockerManager.reloadContentBlocker(withIdentifier: extensionId) { error in
            print(error as Any)
        }
    }
    
}

