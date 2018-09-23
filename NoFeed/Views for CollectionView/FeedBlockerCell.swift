//
//  FeedBlockerCell.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class FeedBlockerCell: UICollectionViewCell, BlockerCell {
    
    var dataSource: BlockerCellDataProvider? {
        didSet {
            guard let dataSource = dataSource else { return }
            updateContent(with: dataSource)
        }
    }
    
    func setBlockerIsOn(_ isOn: Bool) {
        switchView.isOn = isOn
    }
    
    var isBlockerOn: Bool {
        return switchView.isOn
    }
    
    func selected() {
        switchView.onThumbSelected()
    }
    
    private let cornerRadius: CGFloat = 5.0
    private let textSize: CGFloat = 16.5
    
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
        return imageView
    }()
    
    private lazy var switchView: CustomSwitch = {
        let switchView = CustomSwitch(frame: .zero)
        switchView.thumbSize = CGSize(width: 10, height: 10)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        return switchView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(blockerView)
        blockerView.addSubview(label)
        blockerView.addSubview(imageView)
        blockerView.addSubview(switchView)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateContent(with dataSource: BlockerCellDataProvider) {
        blockerView.backgroundColor = dataSource.brandingColor
        label.text = dataSource.title
        imageView.image = UIImage(named: dataSource.imageName)
    }
    
    private func setupConstraints() {
        //TODO: replace constraints with relative values depending on size of the cell
        let blockerViewConstraints = blockerView.constraintsWithAnchorsEqual(to: contentView)
        
        let imageViewConstraints = [
            imageView.centerXAnchor.constraint(equalTo: blockerView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: blockerView.topAnchor, constant: 23.0),
            imageView.heightAnchor.constraint(equalToConstant: 58.0),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0),
        ]
        
        let labelConstraints = [
            label.centerXAnchor.constraint(equalTo: blockerView.centerXAnchor),
            label.topAnchor.constraint(equalTo: blockerView.topAnchor, constant: 86.0),
            label.widthAnchor.constraint(equalTo: blockerView.widthAnchor, multiplier: 0.8),
            label.heightAnchor.constraint(equalToConstant: 23.0)
        ]
        
        let switchConstraints = [
            switchView.bottomAnchor.constraint(equalTo: blockerView.bottomAnchor, constant: -13.0),
            switchView.rightAnchor.constraint(equalTo: blockerView.rightAnchor, constant: -18.0),
            switchView.widthAnchor.constraint(equalToConstant: 44.0),
            switchView.heightAnchor.constraint(equalTo: switchView.widthAnchor, multiplier: 0.5)
        ]
        
        NSLayoutConstraint.activate(blockerViewConstraints + labelConstraints + imageViewConstraints + switchConstraints)
    }
    
}
