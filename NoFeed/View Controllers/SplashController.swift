//
//  SplashController.swift
//  NoFeed
//
//  Created by Vova Seuruk on 11/20/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class SplashController: UIViewController {
    
    private let imageView: UIImageView = {
        let image = UIImage(named: "RoundedAppIcon")
        let imageView = UIImageView(image: image).viewForAutoLayout()
        return imageView
    }()
    
    override func viewDidLoad() {
        view.addSubview(imageView)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150.0)
            ])
    }
    
}
