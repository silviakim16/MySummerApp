//
//  School.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import Foundation

class School {
    
    let name: String
    var topics: [Topic] = []
    
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
}
