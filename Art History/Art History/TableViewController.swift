//
//  TableViewController.swift
//  Art History
//
//  Created by Dusty on 3/16/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var eraList = [String]()
    var eraData = artDescriptionDataHandler()
    var File = "artHistory"
    var selectedEra = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        eraData.loadData(filename: File)
        eraList=eraData.getEra()

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
        return eraList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eraIdentifier", for: indexPath)

        cell.textLabel?.text=eraList[indexPath.row]
        selectedEra=indexPath.row

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectionShowSegue"
        {
                
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let descriptionOfEra = eraData.getDescription(index: indexPath.row)
                let detailVC = (segue.destination as! UINavigationController).topViewController as! CollectionViewController
                
                
                detailVC.title = eraList[indexPath.row]
                detailVC.describeEra = descriptionOfEra
                detailVC.selected = indexPath.row
            }
        }
    }
}
