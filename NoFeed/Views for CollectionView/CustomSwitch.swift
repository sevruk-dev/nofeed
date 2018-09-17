//
//  CustomSwitch.swift
//  NoFeed
//
//  Created by Vova Seuruk on 9/12/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class CustomSwitch: UIControl {
    
    public var thumbSize: CGSize? = nil { didSet { layoutSubviews() } }
    public var padding: CGFloat = 5.0 { didSet { layoutSubviews() } }
    
    private let onTintColor = UIColor(red: 144, green: 202, blue: 119, alpha: 1)
    private let offTintColor = UIColor.lightGray
    private let cornerRadius: CGFloat = 0.5
    private let thumbCornerRadius: CGFloat = 0.5
    private let thumbTintColor = UIColor.white
    private let animationDuration: Double = 0.5
    
    private var isOn = false
    private var isAnimating = false
    private var onPoint = CGPoint.zero
    private var offPoint = CGPoint.zero
    
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
        addSubview(thumbView)
        
        addTarget(self, action: #selector(onThumbSelected), for: .touchUpInside)
    }
    
    private func clear() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    @objc func onThumbSelected() {
        isOn = !isOn
        isAnimating = true
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.1, options: [.curveEaseOut, .beginFromCurrentState],
                       animations: {
                        self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
                        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        }, completion: { _ in
            self.isAnimating = false
            self.sendActions(for: .valueChanged)
        })
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !isAnimating {
            layer.cornerRadius = bounds.height * cornerRadius
            backgroundColor = isOn ? onTintColor : offTintColor
            
            let _thumbSize: CGSize
            
            if let thumbSize = thumbSize {
                _thumbSize = thumbSize
            } else {
                let thumbHeight = bounds.height - 2 * padding
                _thumbSize = CGSize(width: thumbHeight, height: thumbHeight)
            }
            let yPostition = (bounds.height - _thumbSize.height) / 2
            
            onPoint = CGPoint(x: bounds.width - _thumbSize.width - padding, y: yPostition)
            offPoint = CGPoint(x: padding, y: yPostition)
            
            thumbView.frame = CGRect(origin: isOn ? onPoint : offPoint, size: _thumbSize)
            thumbView.layer.cornerRadius = _thumbSize.height * thumbCornerRadius
        }
    }
    
}
