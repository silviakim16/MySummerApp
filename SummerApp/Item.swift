//
//  TextDescription.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//
import Foundation


class Item: NSObject, NSCoding {
    
    var name: String
    var htmlString: String = ""
    var mainTitle: String = ""
    
    enum UDKeys: String {
        case name
        case htmlString
        case mainTitle
        
        var key: String {
            return "Item" + self.rawValue + "Key"
        }
    }

    
    init(name: String) {
        self.name = name
    }
    
    func loadItemInfo(from itemInfoDictionary: [String: Any]) {
        htmlString = HTMLConverter.generateHTMLString(from: itemInfoDictionary)
        //print(htmlString)
    }
    
    // MARK: - Encoding
    public func encode(with aCoder: NSCoder) {
        //This function will save the data
        aCoder.encode(name, forKey: UDKeys.name.key)
        aCoder.encode(htmlString, forKey:UDKeys.htmlString.key)
        aCoder.encode(mainTitle, forKey: UDKeys.mainTitle.key)

    }
    
    public required init?(coder aDecoder: NSCoder) {
        //This function will load the saved data
        name = aDecoder.decodeObject(forKey: UDKeys.name.key) as! String
        htmlString = aDecoder.decodeObject(forKey: UDKeys.htmlString.key) as! String
        mainTitle = aDecoder.decodeObject(forKey: UDKeys.mainTitle.key) as! String
    }

}
