//
//  SharedProtocols.swift
//  NoFeed
//
//  Created by Vova Seuruk on 9/23/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

protocol ContainerManagerProtocol: class {
    
    func blockerIndetifier(for value: String) -> BlockerIdentifier?
    
    var models: [BlockerIdentifier] { get }
    
    func modelExists(with identifier: BlockerIdentifier) -> Bool
    func addModel(with identifier: BlockerIdentifier)
    func removeModel(with identifier: BlockerIdentifier)
    
}

protocol BlockerIdentifierable: class {
    
    var identifier: String { get }
    
}

enum BlockerIdentifier: String {
    case facebook, instagram, twitter, vk
}
