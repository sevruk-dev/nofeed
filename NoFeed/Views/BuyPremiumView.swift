//
//  BuyPremiumView.swift
//  NoFeed
//
//  Created by Sevruk, Vladimir on 10/26/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class BuyPremiumView: UIView {
    
    class var minimalHeight: CGFloat {
        return BuyPremiumView.height + BuyPremiumView.bottomOffset
    }
    
    let button = BuyPremiumButton().viewForAutoLayout()
    
    private let sideOffset: CGFloat = 18.0
    static private let bottomOffset: CGFloat = 15.0
    static private let height: CGFloat = 75.0
    
    convenience init(with dataSource: BlockerCellDataProvider) {
        self.init(frame: .zero)
        button.dataSource = dataSource
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(button)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: sideOffset),
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -sideOffset),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -BuyPremiumView.bottomOffset),
            button.heightAnchor.constraint(equalToConstant: BuyPremiumView.height)
            ])
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class BuyPremiumButton: UIControl, BlockerView {
    
    var dataSource: BlockerCellDataProvider? {
        didSet {
            updateContent()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = cornerRadius
        backgroundColor = UIColor.AppColors.darkGray
        
        addSubview(iconView)
        addSubview(titleLabel)
        
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let imageOffset: CGFloat = 24.0
    private let imageWidth: CGFloat = 28.0
    private let labelOffset: CGFloat = 36.0
    
    private let iconView = UIImageView().viewForAutoLayout()
    
    private let titleLabel: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.font = UIFont.avenirNextMedium(of: 18.0)
        label.textColor = .white
        return label
    }()
    
    private func updateContent() {
        titleLabel.text = dataSource?.title
        guard let imageName = dataSource?.imageName else {
            return
        }
        iconView.image = UIImage(named: imageName)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            iconView.leftAnchor.constraint(equalTo: leftAnchor, constant: imageOffset),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24.0),
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
            titleLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: labelOffset),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
}
