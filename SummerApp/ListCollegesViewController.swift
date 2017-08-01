//
//  ViewController.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import UIKit

class ListCollegesViewController: UITableViewController {

    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchData()

        //Download the data from Firebase using the reference
        FbDatabase.ref.observeSingleEvent(of: .value, with: { (snapshot) in

            //We are going to access the dictionary (data) that was downloaded to snapshot
            if let dataDictionary = snapshot.value as? [String: Any] {
                
                //extracts the data into their own classes by passing dictionary
                Schools.shared.loadSchools(from: dataDictionary)
                self.tableView.reloadData()
            }
        })
        
        self.navigationController?.view.backgroundColor = UIColor.white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayTopicsAndItemsSegue" {
                print("College cell tapped. Displaying Topics and Items")
                let indexPath = tableView.indexPathForSelectedRow!
                let school = Schools.shared.schools[indexPath.row]
                
                let listTopicsAndItemsViewController = segue.destination as! ListTopicsAndItemsViewController
                listTopicsAndItemsViewController.selectedSchool = school
            }
        }
    }
    
    
    // MARK: - Table View Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Schools.shared.schools.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCollegesTableViewCell", for: indexPath)
        //retrieving current row
        let row = indexPath.row
        
        cell.textLabel!.text = Schools.shared.schools[row].name
        
        return cell
    }
    
//    func fetchData() {
//        FbDatabase.resetSharedDatabase()
//        FbDatabase.ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            if let dataDictionary = snapshot.value as? [String : Any] {
//                if let schoolsDictionary = dataDictionary["Schools"] as? [String : Any] {
//                    for schoolName in schoolsDictionary.keys {
//                        let school = School(name: schoolName)
//                        Schools.shared.schools.append(school)
//                        
//                        if let topicsDictionary = schoolsDictionary[schoolName] as? [String: Any] {
//                            for topicName in topicsDictionary.keys {
//                                let topic = Topic(name: topicName)
//                                school.topics.append(topic)
//                            }
//                        }
//                        
//                    }
//                }
//            }
//            self.tableView.reloadData()
//        })
//    }
}

        
