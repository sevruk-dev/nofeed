//
//  ContentBlockerRequestHandler.swift
//  contentBlocker
//
//  Created by Vova Seuruk on 9/20/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import UIKit
import MobileCoreServices

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {
    
    private let containerManager = ContainerManager()
    private let rulesProvider = BlockerRulesProvider()

    //TODO: make informative error description
    
    func beginRequest(with context: NSExtensionContext) {
        let blockingIdentifiers = containerManager.models
        
        guard let blockingRulesUrl = rulesProvider.rulesUrl(for: blockingIdentifiers) else {
            context.cancelRequest(withError: NSError(domain: "RulesProvider", code: 1))
            return
        }
        
        guard let itemProvider = NSItemProvider(contentsOf: blockingRulesUrl) else {
                context.cancelRequest(withError: NSError(domain: "RulesProvider", code: 2))
                return
        }
        
        let item = NSExtensionItem()
        item.attachments = [itemProvider]
        
        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
    
}
