//
//  TextDescription.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

class Item {
    
    var name: String
    var htmlString: String = ""
    var mainTitle = ""
    
    init(name: String) {
        self.name = name
    }
    
    func loadItemInfo(from itemInfoDictionary: [String: Any]) {
        htmlString = HTMLConverter.generateHTMLString(from: itemInfoDictionary)
        //print(htmlString)
    }
}
