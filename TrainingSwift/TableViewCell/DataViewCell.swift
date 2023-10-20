//
//  DataViewCell.swift
//  TrainingSwift
//
//  Created by ITBCA on 19/10/23.
//

import UIKit

class DataViewCell: UITableViewCell {

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValue(idValue: Int, nameValue: String, salaryValue: Int) {
        lblID.text = String(idValue)
        lblName.text = nameValue
        lblSalary.text = String(salaryValue)
    }
    
}
