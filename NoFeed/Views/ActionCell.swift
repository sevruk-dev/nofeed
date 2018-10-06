//
//  ActionCell.swift
//  NoFeed
//
//  Created by Vova Seuruk on 9/17/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class ActionCell: UICollectionViewCell, BlockerCell {
    
    var dataSource: BlockerCellDataProvider? {
        didSet {
            guard let dataSource = dataSource else { return }
            updateContent(with: dataSource)
        }
    }
    
    private let cornerRadius: CGFloat = 5.0
    private let textSize: CGFloat = 13.5
    
    private lazy var backdropView: UIView = {
        let view = UIView().viewForAutoLayout()
        view.backgroundColor = .white
        view.layer.cornerRadius = self.cornerRadius
        return view
    }()
    
    private lazy var shadowView: UIView = {
        let view = ShadowView(frame: .zero).viewForAutoLayout()
        view.cornerRadius = cornerRadius
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.avenirNextMedium(of: self.textSize)
        label.textColor = UIColor.AppColors.spaceGray
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView().viewForAutoLayout()
        imageView.contentMode = .center
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(shadowView)
        contentView.addSubview(backdropView)
        backdropView.addSubview(label)
        backdropView.addSubview(imageView)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateContent(with dataSource: BlockerCellDataProvider) {
        label.text = dataSource.title
        imageView.image = UIImage(named: dataSource.imageName)
    }
    
    private func setupConstraints() {
        //TODO: replace constraints with relative values depending on size of the cell
        let shadowViewConstraints = shadowView.constraintsWithAnchorsEqual(to: contentView)
        let backdropViewConstraints = backdropView.constraintsWithAnchorsEqual(to: contentView)
        
        let imageViewConstraints = [
            imageView.centerXAnchor.constraint(equalTo: backdropView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: backdropView.topAnchor, constant: 16.0),
            imageView.heightAnchor.constraint(equalToConstant: 30.0),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0),
            ]
        
        let labelConstraints = [
            label.centerXAnchor.constraint(equalTo: backdropView.centerXAnchor),
            label.topAnchor.constraint(equalTo: backdropView.topAnchor, constant: 50.0),
            label.widthAnchor.constraint(equalTo: backdropView.widthAnchor, multiplier: 0.7),
            label.heightAnchor.constraint(equalToConstant: 39.0)
        ]
        
        NSLayoutConstraint.activate(shadowViewConstraints + backdropViewConstraints + labelConstraints + imageViewConstraints)
    }
}
