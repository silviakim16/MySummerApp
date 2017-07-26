//
//  TextDescription.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

class Item {
    
    var name: String
    
    var itemInfos = [ItemInfo]()
    
    init(name: String) {
        self.name = name
    }
    
    func loadItemInfo(from itemInfoDictionary: [String: Any]) {
        
        for _ in itemInfoDictionary.keys {
            
            //print("\(#function) KEY: \(key)")
            
            guard let title = itemInfoDictionary["Title"] as? String,
                let text = itemInfoDictionary["Text"] as? String,
                let links = itemInfoDictionary["Links"] as? String,
                let uid = itemInfoDictionary["UID"] as? String
                else {
                    return
            }
            
            itemInfos.append(ItemInfo(title: title, text: text, links: links, uid: uid))
        }
    }
}
