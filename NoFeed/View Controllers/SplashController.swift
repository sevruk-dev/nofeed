//
//  SplashController.swift
//  NoFeed
//
//  Created by Vova Seuruk on 11/20/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class SplashController: UIViewController {
    
    private let imageView: UIImageView = UIImageView().viewForAutoLayout()
    
    private let label: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.textAlignment = .center
        label.font = UIFont.avenirNextRegular(of: 24.0)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(netHex: 0x643FC1)
        
        imageView.image = UIImage(named: "IconWithoutBackground")
        label.text = "by Insider.io"
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150.0),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55.0)
            ])
    }
    
}
