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

typealias OptionalBlock = (() -> ())?

class PopupView: UIView {
    
    private let dialogViewWidth: CGFloat = 270.0
    private let dialogViewHeight: CGFloat = 235.0
    private let hintLabelPadding: CGFloat = 70.0
    
    private let closeCompletion: OptionalBlock
    private let restoreCompletion: OptionalBlock
    private let becomePremiumCompletion: OptionalBlock
    private let purchaseCompletion: OptionalBlock
    
    var isVisible: Bool {
        didSet {
            alpha = isVisible ? 1.0 : 0.0
            fadeView.alpha = isVisible ? 0.92 : 0.0
        }
    }
    
    private let dialogView: PopupDialogView
    
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
    
    convenience init(becomePremiumCompletion: OptionalBlock, closeCompletion: OptionalBlock) {
        self.init(with: .versionLimits, purchaseBlock: becomePremiumCompletion, closeBlock: closeCompletion)
    }
    
    convenience init(purchaseCompletion: OptionalBlock = nil, restoreCompletion: OptionalBlock = nil, closeCompletion: OptionalBlock = nil) {
        self.init(with: .buyPremium, purchaseBlock: purchaseCompletion, restoreBlock: restoreCompletion, closeBlock: closeCompletion)
    }
    
    private init(with type: PopupType, purchaseBlock: OptionalBlock = nil, restoreBlock: OptionalBlock = nil,
                 becomePremiumBlock: OptionalBlock = nil, closeBlock: OptionalBlock = nil) {
        isVisible = false
        dialogView = PopupDialogView(with: type).viewForAutoLayout()
        purchaseCompletion = purchaseBlock
        restoreCompletion = restoreBlock
        becomePremiumCompletion = becomePremiumBlock
        closeCompletion = closeBlock
        super.init(frame: .zero)
        
        dialogView.delegate = self
        backgroundColor = .clear
        
        addSubview(fadeView)
        addSubview(dialogView)
        addSubview(hintLabel)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onClose))
        fadeView.addGestureRecognizer(gestureRecognizer)
        
        setupConstraints()
    }
    
    @objc private func onClose() {
        closeCompletion?()
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
            dialogView.heightAnchor.constraint(equalToConstant: dialogViewHeight),
            hintLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            hintLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -hintLabelPadding)
        ]
        
        NSLayoutConstraint.activate(fadeViewConstraints + dialogViewConstraints)
    }
}

extension PopupView: PopupDialogDelegate {
    
    func dialogViewDidPressBecomePremium() {
        becomePremiumCompletion?()
    }
    
    func dialogViewDidPressCancel() {
        onClose()
    }
    
    func dialogViewDidPressPurchase() {
        purchaseCompletion?()
    }
    
    func dialogViewDidPressRestorePurchase() {
        restoreCompletion?()
    }
}
