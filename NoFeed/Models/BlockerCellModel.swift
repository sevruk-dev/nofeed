//
//  BlockerCellModel.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

protocol BlockerCellDataProvider: BlockerViewDataDescriptor, BlockerIdentifierable { }

protocol BlockerViewDataDescriptor {
    
    var title: String { get }
    var imageName: String { get }
    
}

class BlockerCellModel: BlockerCellDataProvider {
    
    let title: String
    let imageName: String
    
    init(with title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}

extension BlockerCellModel: BlockerIdentifierable {
    
    var identifier: String {
        return title
    }
    
}
