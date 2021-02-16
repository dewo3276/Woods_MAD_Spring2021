//
//  TableViewController.swift
//  CU Majors
//
//  Created by Dusty on 2/16/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var collegeData = collegeMajorLoader()
    var selectedCollege = 0
    var collegeList = [String]()
    let dataFile = "collegeMajors"

    override func viewDidLoad() {
        super.viewDidLoad()
        collegeData.loadData(filename: dataFile)
        collegeList=collegeData.getCollege()
        
        //enables large titles
        navigationController?.navigationBar.prefersLargeTitles = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            collegeList.remove(at: indexPath.row)
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
            //Delete from the data model instance
            collegeData.deleteCollege(index: selectedCollege, collegeIndex: indexPath.row)
        
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let fromRow = fromIndexPath.row //row being moved from
        let toRow = to.row //row being moved to
        let moveCollege = collegeList[fromRow] //country being moved
        //swap positions in array
        collegeList.swapAt(fromRow, toRow)
        //move in data model instance
        collegeData.deleteCollege(index: selectedCollege, collegeIndex: fromRow)
        collegeData.addCollege(index: selectedCollege, newCollege: moveCollege, newIndex: toRow)
    }
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            if let source = segue.source as? addCollegeController {
                //only add a country if there is text in the textfield
                if source.addedCollege.isEmpty == false{
                    //add country to our data model instance
                    collegeData.addCollege(index: selectedCollege, newCollege: source.addedCollege, newIndex: collegeList.count)
                    //add country to the array
                    collegeList.append(source.addedCollege)
                    tableView.reloadData()
                }
            }
        }
    }
    

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let detailVC = segue.destination as? DetailViewController {
                if let indexPath = tableView.indexPath(for: (sender as? UITableViewCell)!) {
                    //sets the data for the destination controller
                    detailVC.title = collegeList[indexPath.row]
                    detailVC.collegeData = collegeData
                    detailVC.selectedCollege = indexPath.row
                }
            }
    }
    

}
