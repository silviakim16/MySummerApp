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
    var selectedTopicName: String = "About"

    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Actions
    @IBAction func aboutTopicButtonTapped(_ sender: Any) {
        reloadTableForTopic("About")
    }
    
    @IBAction func financialTopicButtonTapped(_ sender: Any) {
       reloadTableForTopic("Grants & Funding")
    }
    
    @IBAction func legalTopicButtonTapped(_ sender: Any) {
        reloadTableForTopic("Legal Support")
    }
    
    @IBAction func mentalTopicButtonTapped(_ sender: Any) {
        reloadTableForTopic("Mental Health Support")
    }
    
    @IBAction func academicTopicButtonTapped(_ sender: Any) {
        reloadTableForTopic("Academic Support")
    }

    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayItemInfoContentSegue" {
                print("Item cell tapped. Displaying ItemInfo Content")
                let indexPath = tableView.indexPathForSelectedRow!
                let item = topic!.items[indexPath.row]
                
                let listItemInfoContentViewController = segue.destination as! ListItemInfoContentViewController
                listItemInfoContentViewController.selectedItem = item
            }
        }
    }
    
   
    
    // MARK: - Methods
    func reloadTableForTopic(_ name: String) {
        if selectedSchool != nil {
            for tempTopic in selectedSchool!.topics {
                if tempTopic.name == name {
                    topic = tempTopic
                    selectedTopicName = name
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
