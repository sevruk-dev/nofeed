//
//  ViewController.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/4/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit
import Crashlytics

class ViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Default text"
        label.textAlignment = .center
        return label
    }()
    
    convenience init() {
        self.init(with: nil)
    }
    
    init(with title: String?) {
        super.init(nibName: nil, bundle: nil)
        label.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(label)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: view.leftAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0),
            label.rightAnchor.constraint(equalTo: view.rightAnchor),
            label.heightAnchor.constraint(equalToConstant: 40.0)
            ])
    }

}

