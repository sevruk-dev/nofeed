//
//  BlockerReusableView.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class BlockerReusableView: UITableViewHeaderFooterView {
    
    var title: String? {
        didSet { label.text = title }
    }
    
    private let sideOffset: CGFloat = 30.0
    
    private lazy var label: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.font = UIFont.avenirNextMedium(of: 17.0)
        label.textColor = UIColor.AppColors.spaceGray
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: sideOffset),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: sideOffset),
            ])
    }
}
