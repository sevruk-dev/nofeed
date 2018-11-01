//
//  RoundButton.swift
//  NoFeed
//
//  Created by Vova Seuruk on 10/29/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class RoundButton: UIControl {
    
    private let height: CGFloat = 25.0
    
    private let imageView: UIImageView = {
        let imageView = UIImageView().viewForAutoLayout()
        imageView.image = UIImage(named: "done")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = frame.width / 2
        backgroundColor = UIColor.AppColors.lightPink
        addSubview(imageView)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: height),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
    }
    
}
