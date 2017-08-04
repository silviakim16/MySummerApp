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
    
    @IBOutlet weak var financialTopicButton: UIBarButtonItem!
    @IBOutlet weak var legalTopicButton: UIBarButtonItem!
    @IBOutlet weak var aboutTopicButton: UIBarButtonItem!
    @IBOutlet weak var mentalHealthTopicButton: UIBarButtonItem!
    @IBOutlet weak var academicTopicButton: UIBarButtonItem!
    
    
    // MARK: - Actions
    @IBAction func aboutTopicButtonTapped(_ sender: Any) {
        reloadTableForTopic("About")
        title = "About"
        
//        aboutTopicButton.tintColor = UIColor.whitec        
        aboutTopicButton.tintColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
//        aboutTopicButton.appearance = UIFont(name: "Avenir", size: 30)
        financialTopicButton.tintColor = UIColor.darkGray
        legalTopicButton.tintColor = UIColor.darkGray
        mentalHealthTopicButton.tintColor = UIColor.darkGray
        academicTopicButton.tintColor = UIColor.darkGray
        
    }
    
    @IBAction func financialTopicButtonTapped(_ sender: Any) {
        reloadTableForTopic("Grants & Funding")
        title = "Grants & Funding"
        financialTopicButton.tintColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        aboutTopicButton.tintColor = UIColor.darkGray
        legalTopicButton.tintColor = UIColor.darkGray
        mentalHealthTopicButton.tintColor = UIColor.darkGray
        academicTopicButton.tintColor = UIColor.darkGray

    }
    
    @IBAction func legalTopicButtonTapped(_ sender: Any) {
        reloadTableForTopic("Legal Support")
        title = "Legal Support"
        legalTopicButton.tintColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        aboutTopicButton.tintColor = UIColor.darkGray
        financialTopicButton.tintColor = UIColor.darkGray
        mentalHealthTopicButton.tintColor = UIColor.darkGray
        academicTopicButton.tintColor = UIColor.darkGray

    }
    
    @IBAction func mentalTopicButtonTapped(_ sender: Any) {
        reloadTableForTopic("Mental Health Support")
        title = "Mental Health Support"
        mentalHealthTopicButton.tintColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
//        mentalHealthTopicButton.setBackgroundImage(#imageLiteral(resourceName: "BlueBG"), for: UIControlState.selected, barMetrics: UIBarMetrics.default)
        aboutTopicButton.tintColor = UIColor.darkGray
        legalTopicButton.tintColor = UIColor.darkGray
        financialTopicButton.tintColor = UIColor.darkGray
        academicTopicButton.tintColor = UIColor.darkGray

    }
    
    @IBAction func academicTopicButtonTapped(_ sender: Any) {
        reloadTableForTopic("Academic Support")
        title = "Academic Support"
        academicTopicButton.tintColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        aboutTopicButton.tintColor = UIColor.darkGray
        legalTopicButton.tintColor = UIColor.darkGray
        mentalHealthTopicButton.tintColor = UIColor.darkGray
        financialTopicButton.tintColor = UIColor.darkGray
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
        
        title = "About"
        
        aboutTopicButton.tintColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)


//        financialTopicButton.tintColor = UIColor.blue
//        academicTopicButton.tintColor = UIColor.blue
//        legalTopicButton.tintColor = UIColor.blue
//        aboutTopicButton.tintColor = UIColor.blue
//        mentalHealthTopicButton.tintColor = UIColor.blue
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
