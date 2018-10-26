//
//  BuyPremiumView.swift
//  NoFeed
//
//  Created by Sevruk, Vladimir on 10/26/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class BuyPremiumView: UIView, BlockerView {
    
    var dataSource: BlockerCellDataProvider?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(shadowView)
        addSubview(baseView)
        baseView.addSubview(iconView)
        baseView.addSubview(titleLabel)
        
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            iconView.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: imageOffset),
            iconView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24.0),
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
            titleLabel.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: labelOffset),
            titleLabel.centerYAnchor.constraint(equalTo: baseView.centerYAnchor)
            ] + baseView.constraintsWithAnchorsEqual(to: self) + shadowView.constraintsWithAnchorsEqual(to: baseView))
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let imageOffset: CGFloat = 24.0
    private let imageWidth: CGFloat = 28.0
    private let labelOffset: CGFloat = 36.0
    
    private lazy var baseView: UIView = {
        let view = UIView().viewForAutoLayout()
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var shadowView: UIView = {
        let view = ShadowView(frame: .zero).viewForAutoLayout()
        view.cornerRadius = cornerRadius
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.font = UIFont.avenirNextMedium(of: 18.0)
        label.textColor = .white
        return label
    }()
    
    private let iconView = UIImageView().viewForAutoLayout()
    
    private func updateContent() {
        titleLabel.text = dataSource?.title
        guard let imageName = dataSource?.imageName else {
            return
        }
        iconView.image = UIImage(named: imageName)
    }
    
}
