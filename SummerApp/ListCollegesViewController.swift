//
//  ViewController.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import UIKit

class ListCollegesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Second observeSingleEvent gets data from FirebaseDatabase and puts it into snapshot variable
        FbDatabase.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            //Third, we accessing database of snapshot and converting it as a Dictionary and assign it to dataDictionary
            if let dataDictionary = snapshot.value as? [String : Any] {
                
                //Fourth, we access the value of the key of the dictionary we just made
                //and convert it as a Dictionary and assign that dict within a dict to schooldictionary
                if let schoolsDictionary = dataDictionary["Schools"] as? [String : Any] {
                    
                    var counter = 0
                    
                    //fifth, it iterates through both the key and value in the schoolsDictionary
                    for (key, _) in schoolsDictionary {
                        
                        //sixth, we go through each key in the schoolsDictionary and append school name from Database
                        AppDatabase.shared.schools.append(School(name: key))
                        
                        //seventh, we want to load all the topics and add them to each school's topic array
                        if let topicsDictionary = schoolsDictionary[key] as? [String: Any] {
                        
                            //
                            for (key, _) in topicsDictionary {
                                AppDatabase.shared.schools[counter].topics.append(Topic(name: key))
                                
                                //You need to access the dictionaries inside the topicsDictionary values
                                //and loop again to get the data inside
                                
                                
                            }
                        }
                        
                        counter += 1
                    }
                    
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDatabase.shared.schools.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCollegesTableViewCell", for: indexPath) as! ListCollegesTableViewCell
        //retrieving current row
        let row = indexPath.row
        
        cell.textLabel!.text = AppDatabase.shared.schools[row].name
        
        return cell
    }
    

}

