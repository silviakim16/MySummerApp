//
//  Schools.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/21/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import Foundation
import UIKit

class Schools {
    
    static var shared = Schools()
    
    var schools: [School] = []
    var images: [String: UIImage] = [:]
    
    
    //extracts the data into their own classes
    func loadSchools(from dictionary: [String: Any]) {
        
        FbDatabase.resetSharedDatabase()
        
        loadImages(from: dictionary)
        
        if let schoolsDictionary = dictionary["Schools"] as? [String: Any] {
            
            for key in schoolsDictionary.keys {
                
                //print("\(#function) KEY: \(key)")
                
                //School: You're making a new school object and adding it to the schools array.
                
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
    
    
    private func loadImages(from dictionary: [String: Any]) {
        
        if let imagesDictionary = dictionary["Backgrounds"] as? [String: Any] {
            
            for (schoolName, urlToImage) in imagesDictionary {
                
                if let url = NSURL(string: urlToImage as! String),
                    let data = NSData(contentsOf: url as URL),
                    let image = UIImage(data: data as Data) {
                    
                    images[schoolName] = image
                }
            }
        }
    }
}





