//
//  OnboardingDataSource.swift
//  NoFeed
//
//  Created by Vova Seuruk on 11/1/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

protocol OnboardingDataSourceProtocol {
    var controllers: [UIViewController] { get }
}

class OnboardingDataSource: OnboardingDataSourceProtocol {
    
    var controllers: [UIViewController] = [
        OnboardingViewController(with: UIImage(named: "docs"), title: "Current limitations", description: "Unfortunately limiting App’s traffic is not available in iOS, at least yet.\n We’re only available to filter content in Safari and this is what our App is about."),
        OnboardingViewController(with: .table, dataSource: BlockerDataSource(), title: "How it works?", description: "To start blocking a feed choose one from the list, touch it and enjoy your NoFeed experience."),
        OnboardingViewController(with: UIImage(named: "box"), title: "One more thing…", description: "We’re welcome to present you with a\n3-day Premium experience. Enjoy it!")
    ]
    
}
