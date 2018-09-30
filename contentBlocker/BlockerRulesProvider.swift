//
//  BlockerRulesProvider.swift
//  contentBlocker
//
//  Created by Vova Seuruk on 9/29/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

import Foundation

protocol BlockerRulesProviderProtocol {
    func rulesUrl(for identifiers: [BlockerIdentifier]) -> URL?
}

class BlockerRulesProvider: BlockerRulesProviderProtocol {
    
    func rulesUrl(for identifiers: [BlockerIdentifier]) -> URL? {
        let rules = createRules(for: identifiers)
        writeToFile(rules)
        
        return fileUrl
    }
    
    //MARK: private
    
    private let fileName = "blockerData.json"
    
    private lazy var fileUrl: URL? = {
        guard let directoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return directoryUrl.appendingPathComponent(fileName)
    }()
    
    private func createRules(for identifiers: [BlockerIdentifier]) -> String {
        var rules = "["
        
        for identifier in identifiers {
            if let fileContent = content(for: identifier) {
                rules.append(fileContent)
                rules.append(",")
            }
        }
        
        if rules.last == "," {
            _ = rules.popLast()
        }
        rules.append("]")
        
        return rules
    }
    
    private func content(for identifier: BlockerIdentifier) -> String? {
        guard let fileUrl = Bundle.main.url(forResource: identifier.rawValue, withExtension: "json") else {
            return nil
        }
        
        return try? String(contentsOf: fileUrl, encoding: .utf8)
    }
    
    private func writeToFile(_ rules: String) {
        guard let fileUrl = fileUrl else {
            return
        }
        
        try? rules.write(to: fileUrl, atomically: false, encoding: .utf8)
    }
}
