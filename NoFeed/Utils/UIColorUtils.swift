//
//  UIColorUtils.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/24/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct AppColors {
        static let lightPink = UIColor(netHex: 0xFF3482)
        static let lightGray = UIColor(netHex: 0xE6E6E6)
        static let spaceGray = UIColor(netHex: 0x525050)
        static let lightGreen = UIColor(netHex: 0x2FA66C, alpha: 0.82)
        static let blue = UIColor(netHex: 0x008BFF)
        
        static let facebook = UIColor(netHex: 0x3B5998)
        static let instagram = UIColor(netHex: 0x262626)
        static let twitter = UIColor(netHex: 0x1DA1F2)
        static let vk = UIColor(netHex: 0x266A8D)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(netHex:Int, alpha: CGFloat = 1.0) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, alpha: alpha)
    }
}
