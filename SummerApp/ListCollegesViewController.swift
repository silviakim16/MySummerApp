//
//  ViewController.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/18/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import UIKit

class ListCollegesViewController: UITableViewController {
    
    var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //position in middle of screen
        activitySpinner()
    
        
        //Download the data from Firebase using the reference
        FbDatabase.ref.observeSingleEvent(of: .value, with: { (snapshot) in

            //We are going to access the dictionary (data) that was downloaded to snapshot
            if let dataDictionary = snapshot.value as? [String: Any] {
                
                //extracts the data into their own classes by passing dictionary
                Schools.shared.loadSchools(from: dataDictionary)
                //Schools.shared.loadImages(from: dataDictionary)
                self.tableView.reloadData()
                
                //stop spinning
                self.activityIndicator.stopAnimating()

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
    
    
    // MARK: - Methods
    
    func activitySpinner() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.addSubview(activityIndicator)
        activityIndicator.center = tableView.center
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    
    // MARK: - Table View Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Schools.shared.schools.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCollegesTableViewCell", for: indexPath) as! SchooolCell
        //retrieving current row
        let row = indexPath.row
        let schoolName = Schools.shared.schools[row].name
        
        cell.schoolName.text = schoolName
        cell.selectionStyle = .none
        
        if let background = Schools.shared.images[schoolName] {
            cell.schoolBackground.image = background
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

        
