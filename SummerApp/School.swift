//
//  School.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import Foundation

class School: NSObject, NSCoding{
    
    let name: String
    var topics: [Topic] = []
    
    enum UDKeys: String {
        case name
        case topics
        
        var key: String {
            return "School" + self.rawValue + "Key"
        }
    }

    
    init(name: String) {
        self.name = name
    }
    
    func loadTopics(from topicsDictionary: [String: Any] ) {

        for key in topicsDictionary.keys {
            
            //print("\(#function) KEY: \(key)")
            topics.append(Topic(name: key))
            
        }
        
        //loops through each topic in the topics array
        for topic in topics {
            
            if let itemsDictionary = topicsDictionary[topic.name] as? [String: Any] {
                
                //Loads the items of the item dictionary of the school selected
                topic.loadItems(from: itemsDictionary)
            }
        }
    }
    
    // MARK: - Encoding
    public func encode(with aCoder: NSCoder) {
        //This function will save the data
        aCoder.encode(name, forKey: UDKeys.name.key)
        aCoder.encode(topics, forKey: UDKeys.topics.key)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        //This function will load the saved data
        name = aDecoder.decodeObject(forKey: UDKeys.name.key) as! String
        topics = aDecoder.decodeObject(forKey: UDKeys.topics.key) as! [Topic]
    }
}
