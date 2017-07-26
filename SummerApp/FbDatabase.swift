//
//  FbDatabase.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FbDatabase {
    
    static let ref = Database.database().reference()
    
    static var shared = FbDatabase()
    
    static func resetSharedDatabase() {
        FbDatabase.shared = FbDatabase()
    }
}
