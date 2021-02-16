//
//  TableViewController.swift
//  CU Majors
//
//  Created by Dusty on 2/16/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var collegeList = [String]()
    var collegeData = collegeMajorLoader()
    var dataFile = "collegeMajors"
    var selectedCollege = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        collegeData.loadData(filename: dataFile)
        collegeList=collegeData.getCollege()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return collegeList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collegeIdentifier", for: indexPath)

        cell.textLabel?.text = collegeList[indexPath.row]
        selectedCollege=indexPath.row
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "majorViewer" {
            if let detailVC = segue.destination as? DetailTableViewController {
                if let indexPath = tableView.indexPath(for: (sender as? UITableViewCell)!) {
                    //sets the data for the destination controller
                    detailVC.title = collegeList[indexPath.row]
                    detailVC.collegeData = collegeData
                    detailVC.selectedCollege = indexPath.row
                }
            }
        } //for detail disclosure
        else if segue.identifier == "webService"{
            let infoVC = segue.destination as! webViewController
            let URL = collegeData.getURL(index: selectedCollege)
            infoVC.websiteURL=URL
        }
    }
}
