//
//  BlockerCell.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class BlockerCell: UICollectionViewCell {
    
    private let cornerRadius: CGFloat = 5.0
    private let textSize: CGFloat = 17.0
    
    var dataSource: BlockerCellDataProvider? {
        didSet {
            guard let dataSource = dataSource else { return }
            updateContent(with: dataSource)
        }
    }
    
    private lazy var blockerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = self.cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.avenirNextMedium(of: self.textSize)
        label.textColor = .white
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "twitter")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(blockerView)
        blockerView.addSubview(label)
        blockerView.addSubview(imageView)
        
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateContent(with dataSource: BlockerCellDataProvider) {
        blockerView.backgroundColor = dataSource.brandingColor
        label.text = dataSource.title
        imageView.image = UIImage(named: dataSource.title)
    }
    
    private func setupConstraints() {
        let blockerViewConstraints = blockerView.constraintsWithAnchorsEqual(to: contentView)
        
        let imageViewConstraints = [
            imageView.centerXAnchor.constraint(equalTo: blockerView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: blockerView.topAnchor, constant: 30.0),
            imageView.heightAnchor.constraint(equalToConstant: 45.0),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0),
        ]
        
        let labelConstraints = [
            label.centerXAnchor.constraint(equalTo: blockerView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: blockerView.centerYAnchor, constant: 10.0),
            label.widthAnchor.constraint(equalTo: blockerView.widthAnchor, multiplier: 0.5),
            label.heightAnchor.constraint(equalToConstant: 24.0)
        ]
        
        NSLayoutConstraint.activate(blockerViewConstraints + labelConstraints + imageViewConstraints)
    }
    
}
