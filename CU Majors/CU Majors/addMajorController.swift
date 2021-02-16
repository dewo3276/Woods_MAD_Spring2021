//
//  addMajorController.swift
//  CU Majors
//
//  Created by Dusty on 2/16/21.
//

import UIKit

class addMajorController: UIViewController {
    var addedMajor = String()
    
    @IBOutlet weak var majorTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue"{
            if majorTextField.text?.isEmpty == false{
                addedMajor=majorTextField.text!
            }
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
