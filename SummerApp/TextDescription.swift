//
//  TextDescription.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

class Item {
    let label: String
    let title: String
    let description: String
    let links: [String]
    
    init(label: String, title: String, description: String, links: [String]) {
        self.label = label
        self.title = title
        self.description = description
        self.links = links
    }
}
