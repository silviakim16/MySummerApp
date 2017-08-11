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
    var didFailInternetConnection = false
    var didDownloadData = false
    //var tableRefresh: UIRefreshControl!

    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activitySpinner()
        prepareRefreshControl()
        
        if UserDefaults.standard.value(forKey: "didDownloadData") == nil {
            checkConnectionAndDownload()
        } else {
            //It will only get here when the data was already downloaded before; 
            //therefore, we need to load it from wherever it's saved
            Schools.loadData()
            //tableView.reloadData()
        }
        
        
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
    
    
    // MARK: - Private Methods
    
    private func activitySpinner() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.addSubview(activityIndicator)
        activityIndicator.center = tableView.center
        activityIndicator.hidesWhenStopped = true
    }
    
    private func checkConnectionAndDownload() {
        var numOfConnections = 0
        
        //Download the data from Firebase using the reference
        FbDatabase.connectedRef.observe(.value, with: { connection in
            
            self.activityIndicator.startAnimating()
            
            if let connected = connection.value as? Bool, connected {
                print("Connected to the internet.")
                self.didFailInternetConnection = false
                
                FbDatabase.ref.observeSingleEvent(of: .value, with: { snapshot in
                    
                    //We are going to access the dictionary (data) that was downloaded to snapshot
                    if let dataDictionary = snapshot.value as? [String: Any] {
                        
                        Schools.shared.clearPreviousData()
                        FbDatabase.resetSharedDatabase()
                        
                        //extracts the data into their own classes by passing dictionary
                        Schools.shared.loadSchools(from: dataDictionary)
                        
                        self.dataFinishedDownloading()
                    }
                })
                
            } else {
                numOfConnections += 1
                
                if numOfConnections >= 2 {
                    print("Not connected to the internet.")
                    self.presentNoInternetAlert()
                    self.didFailInternetConnection = true
                    if !self.didDownloadData {
                        self.tableView.reloadData()
                    } else {
                        FbDatabase.connectedRef.removeAllObservers()
                    }
                }
            }
        })
    }
    
    
    private func dataFinishedDownloading() {
        //Save all the data using NSCoder and NSCoding
        //var refreshControl: UIRefreshControl!
        
        self.tableView.reloadData()
        
        //stop spinning, data was already downloaded at this point
        self.activityIndicator.stopAnimating()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Last Updated: " + (Schools.shared.formattedPreviousSavedDate() ?? "N/A"))
        
        //We need to know if data was already downloaded. That's why we saving it in UserDefaults. It must persist
        self.didDownloadData = true
        UserDefaults.standard.set(self.didDownloadData, forKey: "didDownloadData")
    }
    
    
    private func presentNoInternetAlert() {
        let alert = UIAlertController(title: "Error", message: "Error connecting to the internet.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.activityIndicator.stopAnimating()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    private func prepareRefreshControl() {
        refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Last Updated: " + (Schools.shared.formattedPreviousSavedDate() ?? "N/A"))
        refreshControl!.addTarget(self, action: #selector(refreshWhenScrollDown), for: .valueChanged)
    }
    
    func refreshWhenScrollDown(sender: UIRefreshControl) {
        //Here we will redownload the data from Firebase to update it
        if !didFailInternetConnection {
            checkConnectionAndDownload()
        }
        refreshControl!.endRefreshing()
    }

    
    // MARK: - Table View Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if didFailInternetConnection {
            return 1
        }
        
        return Schools.shared.schools.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCollegesTableViewCell", for: indexPath) as! SchooolCell
        cell.selectionStyle = .none
        
        if UserDefaults.standard.value(forKey: "didDownloadData") != nil {
            cell.schoolName.textColor = UIColor.white
            //retrieving current row
            let row = indexPath.row
            let schoolName = Schools.shared.schools[row].name
            
            cell.schoolName.text = schoolName
            
            if let background = Schools.shared.images[schoolName] {
                cell.schoolBackground.image = background
            }
            
        } else {
            cell.schoolName.textColor = UIColor.darkGray
            cell.schoolName.text = "No internet connection."
            cell.imageView?.image = UIImage()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if didFailInternetConnection && !didDownloadData {
            return nil
        }
        
        return indexPath
    }
}


