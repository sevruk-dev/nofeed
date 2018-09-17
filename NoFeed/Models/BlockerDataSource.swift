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
        var models: [[BlockerCellDataProvider]] = []
        let facebookModel = BlockerCellModel(with: "facebook", imageName: "facebook", brandingColor: UIColor.AppColors.facebook)
        let instagramModel = BlockerCellModel(with: "instagram", imageName: "instagram", brandingColor: UIColor.AppColors.instagram)
        let twitterModel = BlockerCellModel(with: "twitter", imageName: "twitter", brandingColor: UIColor.AppColors.twitter)
        let vkModel = BlockerCellModel(with: "vk", imageName: "vk", brandingColor: UIColor.AppColors.vk)
        let feeds = [facebookModel, instagramModel, twitterModel, vkModel]
        
        let reviewModel = BlockerCellModel(with: "Leave us a review", imageName: "review")
        let purchaseModel = BlockerCellModel(with: "Buy Premium or Restore Purchase", imageName: "purchase")
        let actions = [reviewModel, purchaseModel]
        
        models.append(feeds)
        models.append(actions)
        
        return models
    }()
    
    
    //MARK: BlockerDataProvider
    
    func titleForSupplementaryView(at indexPath: IndexPath) -> String {
        return indexPath.section == 0 ? "Feeds to block:" : "And not about blocking:"
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
