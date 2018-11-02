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
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    enum Destination {
        case safariSetup
        case onBoarding
        case main
    }
    
    func navigate(to destination: Destination) {
        let viewController = createViewController(for: destination)
        styleNavigationBar(for: destination)
        setup(viewController)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func createViewController(for desination: Destination) -> UIViewController {
        // TODO: insert factory here
        switch desination {
            case .safariSetup:
                return SafariSetupViewController()
            case .onBoarding:
                return OnboardingPageViewController(with: OnboardingDataSource())
            case .main:
                return BlockerViewController(with: BlockerDataSource())
        }
    }
    
    private func styleNavigationBar(for destination: Destination) {
        let navigationBarHidden = { () -> Bool in
            switch destination {
                case .safariSetup, .onBoarding:
                    return true
                default:
                    return false
            }
        }()
        navigationController.isNavigationBarHidden = navigationBarHidden
    }
    
    private func setup(_ viewController: UIViewController) {
        if let onboardingController = viewController as? OnboardingPageViewController {
            onboardingController.delegate = self
        }
    }
}

extension AppNavigator: OnboardingDelegate {
    
    func onboardingCompleted() {
        navigate(to: .main)
    }
    
}
