//
//  ContainerManagerProtocol.swift
//  NoFeed
//
//  Created by Vova Seuruk on 9/23/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

protocol ContainerManagerProtocol: class {
    
    func blockerIndetifier(for value: String) -> BlockerIdentifier?
    func addModel(with identifier: BlockerIdentifier)
    func removeModel(with identifier: BlockerIdentifier)
    
}

enum BlockerIdentifier: String {
    case facebook, instagram, twitter, vk
}
