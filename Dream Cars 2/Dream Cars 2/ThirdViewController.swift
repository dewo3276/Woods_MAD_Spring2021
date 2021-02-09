//
//  ThirdViewController.swift
//  Dream Cars 2
//
//  Created by Dusty on 2/4/21.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBAction func timerButton(_ sender: UIButton) {
        if(UIApplication.shared.canOpenURL(URL(string: "clock-stopwatch://")!)){
            //open the app with this URL scheme
            UIApplication.shared.open(URL(string: "clock-stopwatch://")!, options: [:], completionHandler: nil)
        } else {
                UIApplication.shared.open(URL(string: "https://www.timeanddate.com/stopwatch/")!, options: [:], completionHandler: nil)
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
