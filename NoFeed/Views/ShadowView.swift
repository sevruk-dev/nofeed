//
//  ShadowView.swift
//  NoFeed
//
//  Created by Vova Seuruk on 9/18/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    var cornerRadius: CGFloat = 0.0
    
    override var bounds: CGRect { didSet { updateShadow() } }
    
    private func updateShadow() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.23
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
}
