//
//  FirstViewController.swift
//  Dream cars
//
//  Created by Dusty on 2/4/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var carPicker: UIPickerView!
    @IBOutlet weak var carPickerLabel: UILabel!
    
    
    var carData = DataLoader()
    var make = [String]()
    var model = [String]()
    let MakeComp = 0
    let ModelComp = 1
    let filename = "dreamCars"
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == MakeComp {
            return make.count
        } else {
            return model.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == MakeComp{
            return make[row]
        }
        else{
            return model[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component==MakeComp{
            model = carData.getModel(index: row)
            carPicker.reloadComponent(ModelComp)
            carPicker.selectRow(0, inComponent: ModelComp, animated: true)
        }
        let makeRow = pickerView.selectedRow(inComponent: MakeComp)
        let modleRow = pickerView.selectedRow(inComponent: ModelComp)
        carPickerLabel.text="You dream of owning an \(make[makeRow]) \(model[modleRow])"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carData.loadData(filename: filename)
        make = carData.getMake()
        model = carData.getModel(index: 0)
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
