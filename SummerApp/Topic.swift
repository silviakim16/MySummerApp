//
//  Topic.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import Foundation

class Topic {
    let name: String
    //var dictionary: [String: [TextDescription]]
    
    var dictionary: [String: [Item]]
    
    init(name: String) {
        self.name = name
        self.dictionary = [String: [Item]]()
    }
}
