//
//  OnboardingViewController.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/4/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit
import Crashlytics

class OnboardingViewController: UIViewController {
    
    enum ControllerType {
        case image, cell
    }
    
    private let type: ControllerType
    private let descriptionLabelRatio: CGFloat = 0.8404
    
    private let titleLabel: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.font = UIFont.avenirNextMedium(of: 21.5)
        label.textColor = UIColor.AppColors.onboardingTextColor
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.numberOfLines = 0
        label.font = UIFont.avenirNextRegular(of: 16.0)
        label.textColor = UIColor.AppColors.onboardingTextColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var blockerCell: BlockerTableViewCell = {
        let cell = BlockerTableViewCell().viewForAutoLayout()
        return cell
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView().viewForAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        return imageView
    }()
    
    convenience init(with image: UIImage?, title: String, description: String) {
        self.init(with: .image, title: title, description: description)
        imageView.image = image
    }
    
    convenience init(with dataSource: BlockerCellDataProvider, title: String, description: String) {
        self.init(with: .cell, title: title, description: description)
        blockerCell.dataSource = dataSource
    }
    
    init(with type: ControllerType, title: String, description: String) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        let viewToAdd = type == .image ? imageView : blockerCell
        view.addSubview(viewToAdd)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200.0),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18.0),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: descriptionLabelRatio)
            ])
        
        if type == .image {
            NSLayoutConstraint.activate([
                imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
                imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
                imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0)
                ])
        } else {
            NSLayoutConstraint.activate([
                
                ])
        }
    }

}

