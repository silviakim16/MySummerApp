//
//  ListTopicsAndItemsViewController.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/24/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import UIKit

class ListTopicsAndItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var selectedSchool: School?
    var topic: Topic?
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Actions
    @IBAction func aboutTopicButtonTapped(_ sender: Any) {
        if selectedSchool != nil {
            for tempTopic in selectedSchool!.topics {
                if tempTopic.name == "About" {
                    topic = tempTopic
                    tableView.reloadData()
                }
            }
        }
    }
    
    //

    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        //The table view starts out in About section
        if selectedSchool != nil {
            for tempTopic in selectedSchool!.topics {
                if tempTopic.name == "About" {
                    topic = tempTopic
                    tableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if topic != nil {
            return topic!.items.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicItemsCellIdentifier", for: indexPath)
        let row = indexPath.row

        if topic != nil {
            cell.textLabel!.text = topic!.items[row].name
        } else {
            cell.textLabel!.text = "Failed to download data."
        }
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
