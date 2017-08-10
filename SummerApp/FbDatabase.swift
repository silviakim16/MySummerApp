//
//  FbDatabase.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class FbDatabase {
    
    // MARK: - Variables
    static var shared = FbDatabase()
    static let ref = Database.database().reference()
    static let connectedRef = Database.database().reference(withPath: ".info/connected")
    static let storageRef = Storage.storage()
    
    
    static func resetSharedDatabase() {
        FbDatabase.shared = FbDatabase()
    }
}
