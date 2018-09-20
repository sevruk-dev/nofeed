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

    func beginRequest(with context: NSExtensionContext) {
        guard let fileUrl = Bundle.main.url(forResource: "blockerList", withExtension: "json"),
            let attachment = NSItemProvider(contentsOf: fileUrl) else {
                return
        }
        
        let item = NSExtensionItem()
        item.attachments = [attachment]
        
        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
    
}
