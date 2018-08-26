//
//  NSLayoutConstraintUtils.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/26/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

extension UIView {
    func constraintsWithAnchorsEqual(to view: UIView) -> [NSLayoutConstraint] {
        return [
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leftAnchor.constraint(equalTo: view.leftAnchor)
        ]
    }
}
