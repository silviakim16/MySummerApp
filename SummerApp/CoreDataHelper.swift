//
//  CoreDataHelper.swift
//  SummerApp
//
//  Created by Silvia  Kim on 8/1/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//
////
//
//import UIKit
//import CoreData
//
//class CoreDataHelper {
//    
//    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    static let persistentContainer = appDelegate.persistentContainer
//    static let managedContext = persistentContainer.viewContext
//    
//    var coreDataSchools = [CDSchool]()
//    
//    static func newSchool() -> CDSchool {
//        return NSEntityDescription.insertNewObject(forEntityName: "CDSchool", into: managedContext) as! CDSchool
//    }
//    
////
////    //static methods will go here
////    
////    static func retrieveSchools() -> [Schools] {
////        let fetchRequest = NSFetchRequest<CDSchools>(entityName: "Schools")
////        do {
////            let results = try managedContext.fetch(fetchRequest)
////            return results
////        } catch let error as NSError {
////            print("Could not fetch \(error)")
////        }
////        return []
////    }
//}
