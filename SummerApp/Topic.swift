//
//  Topic.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import Foundation

class Topic: NSObject, NSCoding {
    let name: String
    //var dictionary: [String: [TextDescription]]
    
    var items = [Item]()
    
    enum UDKeys: String {
        case name
        case items
        
        var key: String {
            return "Topic" + self.rawValue + "Key"
        }
    }

    
    init(name: String) {
        self.name = name
    }
    
    func loadItems(from itemDictionary: [String: Any]) {
        
        for key in itemDictionary.keys {
            
            //print("\(#function) KEY: \(key)")
            
            let item = Item(name: key)
            items.append(item)
            
            if let itemInfoDictionary = itemDictionary[item.name] as? [String: Any] {
                item.loadItemInfo(from: itemInfoDictionary)
            }
        }
    }
    
    // MARK: - Encoding
    public func encode(with aCoder: NSCoder) {
        //This function will save the data
        aCoder.encode(name, forKey: UDKeys.name.key)
        aCoder.encode(items, forKey: UDKeys.items.key)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        //This function will load the saved data
        name = aDecoder.decodeObject(forKey: UDKeys.name.key) as! String
        items = aDecoder.decodeObject(forKey: UDKeys.items.key) as! [Item]
    }
}
