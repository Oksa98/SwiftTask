//
//  ViewController.swift
//  TrainingSwift
//
//  Created by ITBCA on 12/10/23.
//

import UIKit

class ViewController: UIViewController {
    var name: String = ""
    
    @IBOutlet weak var insertName: UITextField!
    
    
    @IBAction func button(_ sender: UIButton) {
        if traitCollection.userInterfaceStyle == .light {
            
            // Switch to light mode
            
            overrideUserInterfaceStyle = .dark
            

        } else {

            // Switch to dark mode

            overrideUserInterfaceStyle = .light


        }
    }
    
    @IBAction func btnProfile(_ sender: Any) {
        performSegue(withIdentifier: "ThridView", sender: nil)
    }
    @IBAction func btnNav(_ sender: Any) {
        name = insertName.text!
        performSegue(withIdentifier: "SecondView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SecondView" {
            let dest = segue.destination as! SecondViewController
            dest.parseName = name
        }
//        if segue.identifier == "ThridView" {
//            let dest2 = segue.destination as! ThridViewController
//        }
    }
    var apiResult : Wrapper = Wrapper(data: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFetchHandler.sharedInstance.fetchAPIData{
            apiData in self.apiResult = apiData
            
            
        }
        // Do any additional setup after loading the view.
    }

}
