//
//  AppNavigator.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/22/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class AppNavigator: Navigator {
    
    private let navigationController: UINavigationController
    private var isFirstLaunch: Bool = true
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    enum Destination {
        case safariSetup
        case onboarding
        case main
    }
    
    func navigate(to destination: Destination) {
        defer {
            styleNavigationBar(for: destination)
            isFirstLaunch = false
        }
        
        //TODO: create enum view types of controllers
        let viewController = createViewController(for: destination)
        
        if let controller = navigationController.viewControllers.first(where: { $0.isKind(of: viewController.classForCoder) }) {
            navigationController.popToViewController(controller, animated: true)
            return
        }
        
        setup(viewController)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func createViewController(for desination: Destination) -> UIViewController {
        //TODO: insert factory here
        switch desination {
            case .safariSetup:
                return SafariSetupViewController()
            case .onboarding:
                return OnboardingPageViewController(with: OnboardingDataSource())
            case .main:
                return BlockerViewController(with: BlockerDataSource())
        }
    }
    
    private func styleNavigationBar(for destination: Destination) {
        let navigationBarHidden = { () -> Bool in
            switch destination {
                case .safariSetup, .onboarding:
                    return true
                default:
                    return false
            }
        }()
        navigationController.setNavigationBarHidden(navigationBarHidden, animated: !isFirstLaunch)
    }
    
    private func setup(_ viewController: UIViewController) {
        if let onboardingController = viewController as? OnboardingPageViewController {
            onboardingController.delegate = self
        }
    }
}

extension AppNavigator: OnboardingDelegate {
    
    func onboardingCompleted() {
        Configuration.shared.setOnboardingCompleted(true)
        navigate(to: .main)
    }
    
}
