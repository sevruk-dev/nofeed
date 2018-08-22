//
//  Navigator.swift
//  NoFeed
//
//  Created by Vova Seuruk on 8/22/18.
//  Copyright © 2018 Vova Seuruk. All rights reserved.
//

protocol Navigator {
    
    associatedtype Destination
    func navigate(to destination: Destination)
    
}
