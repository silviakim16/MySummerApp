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
    var topics: [Topic]
    
    init(name: String) {
        self.name = name
        self.topics = []
    }
}
