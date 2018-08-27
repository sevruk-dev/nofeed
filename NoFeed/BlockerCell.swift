//
//  BlockerCell.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

class BlockerCell: UICollectionViewCell {
    
    var dataSource: BlockerCellDataProvider?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
