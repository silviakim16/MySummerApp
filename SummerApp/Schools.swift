//
//  Schools.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/21/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import Foundation

class Schools {
    
    static var shared = Schools()
    
    var schools: [School] = []
    
    //extracts the data into their own classes
    func loadSchools(from dictionary: [String: Any]) {
        
        FbDatabase.resetSharedDatabase()
        
        if let schoolsDictionary = dictionary["Schools"] as? [String: Any] {
            
            for key in schoolsDictionary.keys {
                
                //print("\(#function) KEY: \(key)")
                
                //School: U making a new school object and adding it to the schools array.
                schools.append(School(name: key))
            }
            
            //loops through each school in the schools array
            for school in schools {
                
                //access the key of school which gets the value in the schoolsDictionary
                //and typecast it as a dictionary then assign it to topic dictionary
                if let topicsDictionary = schoolsDictionary[school.name] as? [String: Any] {
                    
                    //Loads the topics of the topicDictionary of the school selected
                    school.loadTopics(from: topicsDictionary)
                }
            }
        }
    }
}
