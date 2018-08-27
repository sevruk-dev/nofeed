//
//  BlockerCellModel.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

protocol BlockerCellDataProvider {
    
    var title: String { get }
    var image: UIImage { get }
    var brandingColor: UIColor { get }
    
}

class BlockerCellModel: BlockerCellDataProvider {
    
    let title: String
    let image: UIImage
    let brandingColor: UIColor
    
    init(with title: String, brandingColor: UIColor = .white) {
        self.title = title
        self.image = UIImage()
        self.brandingColor = brandingColor
    }
}
