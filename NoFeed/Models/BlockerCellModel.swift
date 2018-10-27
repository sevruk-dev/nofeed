//
//  BlockerCellModel.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

protocol BlockerCellDataProvider: BlockerViewDataDescriptor { }

protocol BlockerViewDataDescriptor {
    
    var title: String { get }
    var imageName: String { get }
    var type: BlockerIdentifier? { get }

}

class BlockerCellModel: BlockerCellDataProvider {
    
    let title: String
    let imageName: String
    let type: BlockerIdentifier?
    
    init(with title: String, imageName: String, type: BlockerIdentifier? = nil) {
        self.title = title
        self.imageName = imageName
        self.type = type
    }
    
}
