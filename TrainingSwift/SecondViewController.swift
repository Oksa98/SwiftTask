//
//  SecondViewController.swift
//  TrainingSwift
//
//  Created by ITBCA on 13/10/23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var secondLabel: UILabel!
    
    var parseName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondLabel.text = parseName
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
