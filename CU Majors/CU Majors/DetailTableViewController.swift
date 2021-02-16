//
//  DetailTableViewController.swift
//  CU Majors
//
//  Created by Dusty on 2/16/21.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var collegeData = collegeMajorLoader()
    var selectedCollege = 0
    var majorList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        majorList = collegeData.getMajors(index: selectedCollege)

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
        return majorList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "majorIdentifier", for: indexPath)
        
        cell.textLabel?.text = majorList[indexPath.row]

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
            majorList.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            collegeData.deleteMajor(index: selectedCollege, majorIndex: indexPath.row)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let majorToMove = majorList[fromIndexPath.row]
        majorList.swapAt(fromIndexPath.row, to.row)
        collegeData.deleteMajor(index: selectedCollege, majorIndex: fromIndexPath.row)
        collegeData.addMajor(index: selectedCollege, newMajor: majorToMove, newIndex: to.row)
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        if segue.identifier == "doneSegue"{
            if let source = segue.source as? addMajor {
                //only add a country if there is text in the textfield
                if source.addedMajor.isEmpty == false{
                    //add country to our data model instance
                    collegeData.addMajor(index: selectedCollege, newMajor: source.addedMajor, newIndex: majorList.count)
                    //add country to the array
                    majorList.append(source.addedMajor)
                    tableView.reloadData()
                }
            }
    }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
