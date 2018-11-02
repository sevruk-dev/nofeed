//
//  BlockerDataSource.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

protocol BlockerDataProvider {
    
    func modelForBuyPremium() -> BlockerCellDataProvider
    
    func titleForSupplementaryView() -> String
    func model(at indexPath: IndexPath) -> BlockerCellDataProvider
    func numberOfItems(at section: Int) -> Int
    
    var numberOfSections: Int { get }
    
}

protocol OnboardingTableDataProvider {
    
    func model(at indexPath: IndexPath) -> BlockerCellDataProvider
    func numberOfItems() -> Int
    
}

class BlockerDataSource: BlockerDataProvider {
    
    private lazy var models: [[BlockerCellDataProvider]] = {
        let facebookModel = BlockerCellModel(with: "facebook", imageName: "facebook", type: .facebook)
        let instagramModel = BlockerCellModel(with: "Instagram", imageName: "instagram", type: .instagram)
        let twitterModel = BlockerCellModel(with: "twitter", imageName: "twitter", type: .twitter)
        let vkModel = BlockerCellModel(with: "vk.com", imageName: "vk", type: .vk)
        
        return [[facebookModel, instagramModel, twitterModel, vkModel] as [BlockerCellDataProvider]]
    }()
    
    
    //MARK: BlockerDataProvider
    
    func modelForBuyPremium() -> BlockerCellDataProvider {
        return BlockerCellModel(with: "Buy Premium", imageName: "purchase")
    }
    
    func titleForSupplementaryView() -> String {
        return "Feeds to block:"
    }
    
    func model(at indexPath: IndexPath) -> BlockerCellDataProvider {
        return models[indexPath.section][indexPath.row]
    }
    
    func numberOfItems(at section: Int) -> Int {
        return models[section].count
    }
    
    var numberOfSections: Int {
        return models.count
    }
    
}

extension BlockerDataSource: OnboardingTableDataProvider {
    
    func numberOfItems() -> Int {
        return 2
    }
    
}
