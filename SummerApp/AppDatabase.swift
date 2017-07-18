//
//  Database.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import Foundation

class AppDatabase {
    
    static var shared = AppDatabase()
    
    var schools: [String : Any]?
    var schoolArr = [String]()
    
    //This function will read the data from inside the schools dictionary
    func readSchools() {
        
        guard schools != nil else {
            return
        }
        
        //Loops a dictionary and gets the key value and adds it to schoolArr
        for (key, _) in schools! {
            print(key)
            schoolArr.append(key)
        }
    }
}
