//
//  PopupDialogView.swift
//  NoFeed
//
//  Created by Vova Seuruk on 10/6/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

protocol PopupDialogDelegate: class {
    func dialogViewDidPressCancel()
    func dialogViewDidPressBecomePremium()
    func dialogViewDidPressPurchase()
    func dialogViewDidPressRestorePurchase()
}

class PopupDialogView: UIView {
    
    weak var delegate: PopupDialogDelegate?
    
    private let type: PopupType
    
    private struct Constants {
        static let textWidth: CGFloat = 226.0
        static let topPadding: CGFloat = 25.0
        static let buttonHeight: CGFloat = 55.0
        static let descriptionTopOffset: CGFloat = 3.0
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.textAlignment = .center
        label.text = headerText(for: self.type)
        label.textColor = UIColor.AppColors.darkGray
        label.font = UIFont.avenirNextDemiBold(of: 19.5)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.avenirNextRegular(of: 15.5)
        label.text = descriptionText(for: self.type)
        label.textColor = UIColor(netHex: 0x8B8B8B)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    lazy var mainActionButton: PopupButton = {
        let button = PopupButton().viewForAutoLayout()
        button.title.text = mainButtonTitle(with: self.type)
        button.title.textColor = UIColor.AppColors.blue
        button.addTarget(self, action: #selector(onMainButton), for: .touchUpInside)
        setupStyle(for: button.title, with: self.type)
        return button
    }()
    
    private lazy var secondaryActionButton: PopupButton = {
        let button = PopupButton().viewForAutoLayout()
        button.title.text = secondaryButtonTitle(with: self.type)
        button.addTarget(self, action: #selector(onSecondaryButton), for: .touchUpInside)
        setupSecondaryStyle(for: button.title, with: self.type)
        return button
    }()
    
    init(with type: PopupType) {
        self.type = type
        super.init(frame: .zero)
        
        layer.cornerRadius = 20.0
        backgroundColor = .white
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(mainActionButton)
        addSubview(secondaryActionButton)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topPadding),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.descriptionTopOffset),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: Constants.textWidth),
            secondaryActionButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            secondaryActionButton.widthAnchor.constraint(equalTo: widthAnchor),
            secondaryActionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            secondaryActionButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainActionButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            mainActionButton.widthAnchor.constraint(equalTo: widthAnchor),
            mainActionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainActionButton.bottomAnchor.constraint(equalTo: secondaryActionButton.topAnchor)
            ])
    }
    
    //MARK: button targets
    
    @objc private func onMainButton() {
        if type == .versionLimits {
            delegate?.dialogViewDidPressBecomePremium()
        } else {
            delegate?.dialogViewDidPressPurchase()
        }
    }
    
    @objc private func onSecondaryButton() {
        if type == .versionLimits {
            delegate?.dialogViewDidPressCancel()
        } else {
            delegate?.dialogViewDidPressRestorePurchase()
        }
    }
    
    //MARK: content data
    
    private func headerText(for type: PopupType) -> String {
        if type == .buyPremium {
            return "Buy Premium"
        }
        return "Version limitations"
    }
    
    private func descriptionText(for type: PopupType) -> String {
        if type == .buyPremium {
            return "With Premium you can lock all your social feeds at a time."
        }
        return "With basic version you are only able to block 1 feed at a time."
    }
    
    private func mainButtonTitle(with type: PopupType) -> String {
        if type == .buyPremium {
            return "Premium for 1.99$"
        }
        return "Become a Premium"
    }
    
    private func secondaryButtonTitle(with type: PopupType) -> String {
        if type == .buyPremium {
            return "Restore Purchase"
        }
        return "Cancel"
    }
    
    //MARK: UI-elements styling
    
    private func setupStyle(for label: UILabel, with type: PopupType) {
        label.font = self.type == .versionLimits ? UIFont.avenirNextDemiBold(of: 18.0) : UIFont.avenirNextMedium(of: 18.0)
    }
    
    private func setupSecondaryStyle(for label: UILabel, with type: PopupType) {
        label.textColor = type == .versionLimits ? UIColor.init(netHex: 0xFF666C) : UIColor.AppColors.blue
        label.font = type == .versionLimits ? UIFont.avenirNextDemiBold(of: 18.0) : UIFont.avenirNextRegular(of: 18.0)
    }
}

class PopupButton: UIButton {
    
    fileprivate let separator: UIView = {
        let view = UIView().viewForAutoLayout()
        view.backgroundColor = UIColor(netHex: 0xCCCBCB)
        return view
    }()
    
    fileprivate lazy var title: UILabel = {
        let title = UILabel().viewForAutoLayout()
        title.font = UIFont.avenirNextRegular(of: 18.0)
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(separator)
        addSubview(title)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: topAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.0),
            separator.widthAnchor.constraint(equalTo: widthAnchor),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}
