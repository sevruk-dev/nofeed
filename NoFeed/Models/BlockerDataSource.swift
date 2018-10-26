//
//  BlockerDataSource.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/27/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit

protocol BlockerDataProvider {
    
    func titleForSupplementaryView() -> String
    func model(at indexPath: IndexPath) -> BlockerCellDataProvider
    func numberOfItems(at section: Int) -> Int
    
    var numberOfSections: Int { get }
    
}

class BlockerDataSource: BlockerDataProvider {
    
    private lazy var models: [[BlockerCellDataProvider]] = {
        let facebookModel = BlockerCellModel(with: "facebook", imageName: "facebook")
        let instagramModel = BlockerCellModel(with: "Instagram", imageName: "instagram")
        let twitterModel = BlockerCellModel(with: "twitter", imageName: "twitter")
        let vkModel = BlockerCellModel(with: "vk.com", imageName: "vk")
        
        return [[facebookModel, instagramModel, twitterModel, vkModel] as [BlockerCellDataProvider]]
    }()
    
    
    //MARK: BlockerDataProvider
    
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
