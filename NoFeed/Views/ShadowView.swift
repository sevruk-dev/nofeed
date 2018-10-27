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
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 1.0
        self.layer.shadowColor = UIColor(netHex: 0xE5E1E1).cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
}
