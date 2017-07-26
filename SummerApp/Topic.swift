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
    
    var items = [Item]()
    
    init(name: String) {
        self.name = name
    }
    
    func loadItems(from itemDictionary: [String: Any]) {
        
        for key in itemDictionary.keys {
            
            //print("\(#function) KEY: \(key)")
            items.append(Item(name: key))
        }
        
        for item in items {
            
            if let itemInfoDictionary = itemDictionary[item.name] as? [String: Any] {
                
                item.loadItemInfo(from: itemInfoDictionary)
            }
        }
    }
}
