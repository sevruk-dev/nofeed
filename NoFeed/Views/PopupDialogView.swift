//
//  PopupDialogView.swift
//  NoFeed
//
//  Created by Vova Seuruk on 10/6/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class PopupDialogView: UIView {
    
    private let type: PopupType
    private let purchaseBlock: (() -> ())?
    private let restoreBlock: (() -> ())?
    
    private let stackViewToWidthRatio: CGFloat = 0.796875
    private let topPadding: CGFloat = 20.0
    private let buttonHeight: CGFloat = 40.0
    private let defaultSpacing: CGFloat = 10.0
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.textAlignment = .center
        label.text = headerText(for: self.type)
        label.font = UIFont.avenirNextDemiBold(of: 19.5)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.avenirNextRegular(of: 15.5)
        label.text = descriptionText(for: self.type)
        label.textColor = UIColor.AppColors.spaceGray
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    lazy var mainActionButton: PopupButtonWithBackground = {
        let button = PopupButtonWithBackground().viewForAutoLayout()
        button.title.text = buttonTitle(for: self.type)
        button.addTarget(self, action: #selector(onMainButton), for: .touchUpInside)
        button.backgroundColor = buttonBackgroundColor(for: self.type)
        return button
    }()
    
    private lazy var secondaryActionButton: PopupButtonWithoutBackground = {
        let button = PopupButtonWithoutBackground().viewForAutoLayout()
        button.addTarget(self, action: #selector(onSecondaryButton), for: .touchUpInside)
        button.title.text = "Restore Purchase"
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView().viewForAutoLayout()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = defaultSpacing
        return stackView
    }()
    
    init(with type: PopupType, purchaseBlock: optionalBlock = nil, restoreBlock: optionalBlock = nil) {
        self.type = type
        self.purchaseBlock = purchaseBlock
        self.restoreBlock = restoreBlock
        super.init(frame: .zero)
        
        layer.cornerRadius = 10.0
        backgroundColor = .white
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(PopupSeparatorView())
        stackView.addArrangedSubview(mainActionButton)
        
        if type == .buyPremium {
            if #available(iOS 11.0, *) {
                stackView.setCustomSpacing(15.0, after: mainActionButton)
            }
            
            stackView.addArrangedSubview(secondaryActionButton)
        }
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topPadding),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: stackViewToWidthRatio),
            mainActionButton.heightAnchor.constraint(equalToConstant: buttonHeight)
            ])
    }
    
    //MARK: button targets
    
    @objc private func onMainButton() {
        purchaseBlock?()
    }
    
    @objc private func onSecondaryButton() {
        restoreBlock?()
    }
    
    //MARK: content data
    
    private func headerText(for type: PopupType) -> String {
        if type == .buyPremium {
            return "Buy Premium"
        }
        return "Basic version limitations"
    }
    
    private func descriptionText(for type: PopupType) -> String {
        if type == .buyPremium {
            return "With Premium you can lock all your social feeds at a time and encourage our team to build even better products for you."
        }
        return "With basic version you are only able to block 1 feed at a time.\n Blocking multiple feeds is available for Premium users."
    }
    
    private func buttonTitle(for type: PopupType) -> String {
        if type == .buyPremium {
            return "Premium for 1.99$"
        }
        return "Become a Premium"
    }
    
    private func buttonBackgroundColor(for type: PopupType) -> UIColor {
        if type == .buyPremium {
            return UIColor.AppColors.blue
        }
        return UIColor.AppColors.lightGreen
    }
    
}

class PopupSeparatorView: UIView {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class PopupButton: UIButton {
    
    fileprivate lazy var title: UILabel = {
        let title = UILabel().viewForAutoLayout()
        title.font = UIFont.avenirNextRegular(of: 18.0)
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}

class PopupButtonWithoutBackground: PopupButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title.textColor = UIColor.AppColors.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class PopupButtonWithBackground: PopupButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title.textColor = .white
        layer.cornerRadius = 5.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
