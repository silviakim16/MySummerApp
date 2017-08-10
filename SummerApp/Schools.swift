//
//  Schools.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/21/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import Foundation
import UIKit

class Schools: NSObject, NSCoding {
    
    static var shared = Schools()
    
    var schools: [School] = []
    var images: [String: UIImage] = [:]
    var lastUpdatedDate: Date!
    
    
    //Removes the warning to initilize the shared object
    override init() {
        //
    }
    
    
    // MARK: - Encoding
    public func encode(with aCoder: NSCoder) {
        //This function will save the data
        aCoder.encode(schools, forKey: "SchoolsKey")
        aCoder.encode(images, forKey: "ImagesKey")
        aCoder.encode(lastUpdatedDate, forKey: "LastUpdatedDateKey")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        //This function will load the saved data
        schools = aDecoder.decodeObject(forKey: "SchoolsKey") as! [School]
        images = aDecoder.decodeObject(forKey: "ImagesKey") as! [String: UIImage]
        lastUpdatedDate = aDecoder.decodeObject(forKey: "LastUpdatedDateKey") as! Date!
    }
    
    class func saveData() {
        let data = NSKeyedArchiver.archivedData(withRootObject: Schools.shared)
        UserDefaults.standard.set(data, forKey: "SchoolsArchivedDataKeys")
    }
    
    //This func loads the savedData
    class func loadData() {
        if let data = UserDefaults.standard.value(forKey: "SchoolsArchivedDataKeys") as? Data {
            Schools.shared = NSKeyedUnarchiver.unarchiveObject(with: data)  as! Schools
        }
    }
    
    
    
    // Will check if data was already downloaded to save to app or redownload
    func didDownloadData(value: Bool) {
        //
    }
    
    
    func clearPreviousData() {
        schools.removeAll()
        images.removeAll()
    }
    
    
    //extracts the data into their own classes
    func loadSchools(from dictionary: [String: Any]) {
    
        loadImages(from: dictionary)
        
        if let schoolsDictionary = dictionary["Schools"] as? [String: Any] {
            
            saveUpdatedDateForFirstTime()
            
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
    
    
    private func saveUpdatedDateForFirstTime() {
        if UserDefaults.standard.value(forKey: "previousUpdateTime") == nil {
            lastUpdatedDate = Date()
            UserDefaults.standard.set(lastUpdatedDate, forKey: "previousUpdateTime")
        }
    }
    
    func formattedPreviousSavedDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if let dateExist = UserDefaults.standard.value(forKey: "previousUpdateTime") as? Date {
            return dateFormatter.string(from: dateExist)
        }
        return nil
    }
}





