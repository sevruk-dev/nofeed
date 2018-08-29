//
//  UIFontUtils.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/29/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

fileprivate struct FontNames {
    static let avenirNextRegular = "AvenirNext-Regular"
    static let avenirNextMedium = "AvenirNext-Medium"
    static let avenirNextDemiBold = "AvenirNext-DemiBold"
}

extension UIFont {
    
    static func avenirNextRegular(of size: CGFloat) -> UIFont {
        return UIFont(name: FontNames.avenirNextRegular, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func avenirNextMedium(of size: CGFloat) -> UIFont {
        return UIFont(name: FontNames.avenirNextMedium, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func avenirNextDemiBold(of size: CGFloat) -> UIFont {
        return UIFont(name: FontNames.avenirNextDemiBold, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
