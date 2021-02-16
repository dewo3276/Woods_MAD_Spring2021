//
//  webViewController.swift
//  CU Majors
//
//  Created by Dusty on 2/16/21.
//

import UIKit
import WebKit

class webViewController: UIViewController {
    @IBOutlet weak var webViewer: WKWebView!
    
    var websiteURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webViewer.load(URLRequest(url: (URL(string: websiteURL) ?? URL(string: "https://www.colorado.edu/academics/programs"))!))
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
