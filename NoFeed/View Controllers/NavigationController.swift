//
//  NavigationController.swift
//  NoFeed
//
//  Created by Sevruk, Vladimir on 10/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        updateBackgroundColor()
        addShadow()
        
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.avenirNextMedium(of: 17.0)]
    }
    
    private func updateBackgroundColor() {
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = UIColor.AppColors.lightGray
        navigationBar.barTintColor = UIColor.AppColors.lightGray
    }
    
    private func addShadow() {
        navigationBar.layer.shadowColor = UIColor.AppColors.spaceGray.cgColor
        navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        navigationBar.layer.shadowRadius = 3.0
        navigationBar.layer.shadowOpacity = 0.4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
