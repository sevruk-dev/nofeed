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
    private let stackViewToWidthRatio: CGFloat = 0.796875
    private let topPadding: CGFloat = 20.0
    private let buttonHeight: CGFloat = 40.0
    private let defaultSpacing: CGFloat = 10.0
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Buy Premium"
        label.font = UIFont.avenirNextDemiBold(of: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.avenirNextRegular(of: 16.0)
        label.text = "With Premium you can lock all your social feeds at a time and encourage our team to build even better products for you."
        label.textColor = UIColor.AppColors.spaceGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    lazy var mainActionButton: PopupButtonWithBackground = {
        let button = PopupButtonWithBackground()
        button.title.text = buttonTitle(for: self.type)
        button.backgroundColor = buttonBackgroundColor(for: self.type)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var secondaryActionButton: PopupButtonWithoutBackground = {
        let button = PopupButtonWithoutBackground()
        button.title.text = "Restore Purchase"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = defaultSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(with type: PopupType) {
        self.type = type
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
        
        if #available(iOS 11.0, *) {
            stackView.setCustomSpacing(15.0, after: mainActionButton)
        }
        
        stackView.addArrangedSubview(secondaryActionButton)
        
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
        let title = UILabel()
        title.font = UIFont.avenirNextRegular(of: 18.0)
        title.translatesAutoresizingMaskIntoConstraints = false
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
