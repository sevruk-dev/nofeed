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
    
    private let constrainerManager = ContainerManager()

    func beginRequest(with context: NSExtensionContext) {
        var attachments: [NSItemProvider] = []
        
        constrainerManager.models.forEach { identifier in
            if let item = attachment(with: identifier) {
                attachments.append(item)
            }
        }
        
        let item = NSExtensionItem()
        item.attachments = attachments
        
        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
    
    private func attachment(with identifier: BlockerIdentifier) -> NSItemProvider? {
        guard let fileUrl = Bundle.main.url(forResource: identifier.rawValue, withExtension: "json") else {
            return nil
        }
        
        return NSItemProvider(contentsOf: fileUrl)
    }
    
}
