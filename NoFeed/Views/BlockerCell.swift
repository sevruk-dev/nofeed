//
//  BlockerCell.swift
//  NoFeed
//
//  Created by Vova Seuruk on 9/17/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

protocol BlockerCell: class {
    
    var dataSource: BlockerCellDataProvider? { get set }
    
}
