//
//  SecondViewController.swift
//  Dream Cars 2
//
//  Created by Dusty on 2/4/21.
//

import UIKit

class SecondViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    var colorPicker=UIColorPickerViewController()
    var selectedColor=UIColor.systemBlue
        

    @IBOutlet weak var circleColor: UIImageView!
    @IBAction func colorPickerButton(_ sender: UIButton) {
        colorPicker.supportsAlpha=false
        colorPicker.selectedColor=selectedColor
        present(colorPicker, animated: true)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        selectedColor=colorPicker.selectedColor
        circleColor.tintColor=selectedColor
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.delegate = self
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
