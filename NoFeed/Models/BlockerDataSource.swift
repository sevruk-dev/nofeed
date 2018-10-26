//
//  BlockerDataSource.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

protocol BlockerDataProvider {
    
    func titleForSupplementaryView(at indexPath: IndexPath) -> String
    func model(at indexPath: IndexPath) -> BlockerCellDataProvider
    func numberOfItems(at section: Int) -> Int
    
    var numberOfSections: Int { get }
    
}

class BlockerDataSource: BlockerDataProvider {
    
    private lazy var models: [[BlockerCellDataProvider]] = {
        let facebookModel = BlockerCellModel(with: "facebook", imageName: "facebook")
        let instagramModel = BlockerCellModel(with: "instagram", imageName: "instagram")
        let twitterModel = BlockerCellModel(with: "twitter", imageName: "twitter")
        let vkModel = BlockerCellModel(with: "vk", imageName: "vk")
        
        return [[facebookModel, instagramModel, twitterModel, vkModel] as [BlockerCellDataProvider]]
    }()
    
    
    //MARK: BlockerDataProvider
    
    func titleForSupplementaryView(at indexPath: IndexPath) -> String {
        return indexPath.section == 0 ? "Feeds to block:" : ""
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
