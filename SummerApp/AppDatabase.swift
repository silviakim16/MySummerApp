//
//  Database.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

class AppDatabase {
    
    static var shared = AppDatabase()
    
    //pull those Dictionary into class
//    var schoolsDictionary: [String : Any]?
//    var schoolArr = [String]()
    
    var schools = [School]()
    
    //This function will read the data from inside the schools dictionary
//    func readSchools() {
//        //if schoolDictionary is nil, then return
//        guard schoolsDictionary != nil else {
//            return
//        }
//        
//        //Loops a dictionary and gets the key value and adds it to schoolArr
//        for (key, _) in schoolsDictionary! {
//            print(key)
//            schoolArr.append(key)
//            
//        }
//    }
}
