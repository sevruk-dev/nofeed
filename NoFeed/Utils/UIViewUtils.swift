//
//  UIViewUtils.swift
//  NoFeed
//
//  Created by Vova Seuruk on 10/6/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

extension UIView {
    
    func viewForAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
}
