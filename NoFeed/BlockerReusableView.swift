//
//  BlockerReusableView.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class BlockerReusableView: UICollectionReusableView {
    
    var title: String? {
        didSet { label.text = title }
    }
    
    private let sideOffset: CGFloat = 25.0
    private let height: CGFloat = 25.0
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: sideOffset),
            label.heightAnchor.constraint(equalToConstant: height),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: sideOffset),
            ])
    }
}
