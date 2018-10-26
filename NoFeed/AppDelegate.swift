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
    private let extensionId = "com.svg.NoFeed.contentBlocker"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let appNavigator = AppNavigator(with: navigationController)
        appCoordinator = AppCoordinator(with: appNavigator)
        appCoordinator?.coordinate()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        reloadContentBlocker()
        configureNavigationBar()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        reloadContentBlocker()
    }
    
    private func reloadContentBlocker() {
        SFContentBlockerManager.reloadContentBlocker(withIdentifier: extensionId) { error in
            print(error as Any)
        }
    }
    
    private func configureNavigationBar() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor.AppColors.lightGray
        UINavigationBar.appearance().barTintColor = UIColor.AppColors.lightGray
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.avenirNextMedium(of: 17.0)]
    }
}

