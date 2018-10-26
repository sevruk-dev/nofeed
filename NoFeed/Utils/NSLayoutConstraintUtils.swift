//
//  NSLayoutConstraintUtils.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/26/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

extension UIView {
    
    func constraintsWithAnchorsEqual(to view: UIView, with insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return [
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left)
        ]
    }
    
}
