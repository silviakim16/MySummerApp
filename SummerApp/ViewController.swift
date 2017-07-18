//
//  ViewController.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonTapped(_ sender: Any) {
        AppDatabase.shared.readSchools()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //observeSingleEvent downloads data from the Database reference and stores it in snapshot
        FbDatabase.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            //we making sure that value in snapshot can be a dictionary
            //checks if the value of the snapshot can be converted into String
            if let dataDictionary = snapshot.value as? [String : Any] {
                if let schoolsDictionary = dataDictionary["Schools"] as? [String : Any] {
                    AppDatabase.shared.schools = schoolsDictionary
                }
            }
        })
    }
}

