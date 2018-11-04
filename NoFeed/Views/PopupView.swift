//
//  PopupView.swift
//  NoFeed
//
//  Created by Vova Seuruk on 9/30/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

enum PopupType {
    case buyPremium, versionLimits
}

typealias optionalBlock = (() -> ())?

class PopupView: UIView {
    
    private let dialogViewWidth: CGFloat = 270.0
    private let hintLabelPadding: CGFloat = 70.0
    
    var isVisible: Bool {
        didSet {
            alpha = isVisible ? 1.0 : 0.0
            fadeView.alpha = isVisible ? 0.92 : 0.0
        }
    }
    
    private lazy var hintLabel: UILabel = {
        let label = UILabel().viewForAutoLayout()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.avenirNextRegular(of: 17.5)
        label.text = "To close this message\n press anywhere outside\n of this message."
        return label
    }()
    
    private lazy var fadeView: UIView = {
        let view = UIView().viewForAutoLayout()
        view.backgroundColor = UIColor(netHex: 0x1E1D1D)
        return view
    }()
    
    private let dialogView: PopupDialogView
    
    convenience init(becomePremiumCompletion: optionalBlock) {
        self.init(with: .versionLimits, purchaseBlock: becomePremiumCompletion)
    }
    
    convenience init(purchaseBlock: optionalBlock = nil, restoreBlock: optionalBlock = nil) {
        self.init(with: .buyPremium, purchaseBlock: purchaseBlock, restoreBlock: restoreBlock)
    }
    
    init(with type: PopupType, purchaseBlock: optionalBlock = nil, restoreBlock: optionalBlock = nil) {
        isVisible = false
        dialogView = PopupDialogView(with: type, purchaseBlock: purchaseBlock, restoreBlock: restoreBlock).viewForAutoLayout()
        super.init(frame: .zero)
        backgroundColor = .clear
        
        addSubview(fadeView)
        addSubview(dialogView)
        addSubview(hintLabel)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hide))
        fadeView.addGestureRecognizer(gestureRecognizer)
        
        setupConstraints()
    }
    
    @objc private func hide() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.isVisible = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        let fadeViewConstraints = fadeView.constraintsWithAnchorsEqual(to: self)
        let dialogViewConstraints = [
            dialogView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dialogView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dialogView.widthAnchor.constraint(equalToConstant: dialogViewWidth),
            hintLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            hintLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -hintLabelPadding)
        ]
        
        NSLayoutConstraint.activate(fadeViewConstraints + dialogViewConstraints)
    }
}
