//
//  CustomSwitch.swift
//  NoFeed
//
//  Created by Vova Seuruk on 9/12/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class CustomSwitch: UIControl {
    
    public var thumbSize: CGSize = .zero { didSet { layoutSubviews() } }
    public var padding: CGFloat = 5.0 { didSet { layoutSubviews() } }
    
    private let onStateAlpha: CGFloat = 1.0
    private let offStateAlpha: CGFloat = 0.3
    private let onTintColor = UIColor(netHex: 0x11842F)
    private let offTintColor = UIColor(netHex: 0xE9E5E5)
    private let cornerRadius: CGFloat = 0.5
    private let thumbCornerRadius: CGFloat = 0.5
    private let thumbTintColor: UIColor = .white
    private let animationDuration: Double = 0.5
    
    private var isOn = false
    private var isAnimating = false
    private var onPoint = CGPoint.zero
    private var offPoint = CGPoint.zero
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var thumbView: UIView = {
        let thumbView = UIView(frame: .zero)
        thumbView.backgroundColor = thumbTintColor
        thumbView.isUserInteractionEnabled = false
        return thumbView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeInitialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeInitialSetup()
    }
    
    private func makeInitialSetup() {
        clear()
        backgroundColor = .clear
        addSubview(backgroundView)
        addSubview(thumbView)
        
        setupConstraints()
        
        addTarget(self, action: #selector(onThumbSelected), for: .touchUpInside)
    }
    
    private func clear() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(backgroundView.constraintsWithAnchorsEqual(to: self))
    }
    
    @objc func onThumbSelected() {
        isOn = !isOn
        isAnimating = true
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.1, options: [.curveEaseOut, .beginFromCurrentState],
                       animations: { [weak self] in
                        
                        guard let strongSelf = self else { return }
                        strongSelf.updateBackgroundViewAlphaAndColor()
                        strongSelf.thumbView.frame.origin.x = strongSelf.isOn ? strongSelf.onPoint.x : strongSelf.offPoint.x
                        
        }, completion: { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.isAnimating = false
            strongSelf.sendActions(for: .valueChanged)
        })
    }
    
    private func updateBackgroundViewAlphaAndColor() {
        if isOn {
            backgroundView.alpha = self.onStateAlpha
            backgroundView.backgroundColor = onTintColor
        } else {
            backgroundView.alpha = self.offStateAlpha
            backgroundView.backgroundColor = offTintColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isAnimating {
            updateCornerRadiusIfNeeded()
            updateBackgroundViewAlphaAndColor()
            
            let yPosition = (bounds.height - thumbSize.height) / 2
            let xPosition = bounds.width - thumbSize.width - padding
            
            onPoint = CGPoint(x: xPosition, y: yPosition)
            offPoint = CGPoint(x: padding, y: yPosition)
            
            thumbView.frame = CGRect(origin: isOn ? onPoint : offPoint, size: thumbSize)
            thumbView.layer.cornerRadius = thumbSize.height * thumbCornerRadius
        }
    }
    
    private func updateCornerRadiusIfNeeded() {
        let newCornerRadius = bounds.height * cornerRadius
        
        if layer.cornerRadius != newCornerRadius {
            layer.cornerRadius = newCornerRadius
            backgroundView.layer.cornerRadius = newCornerRadius
        }
    }
}
