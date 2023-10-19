//
//  EmployeesTableViewCell.swift
//  TrainingSwift
//
//  Created by ITBCA on 18/10/23.
//

import UIKit

class EmployeesTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValue(nameValue: String, ageValue: String, salaryValue: String){
        lblName.text = nameValue
        lblAge.text = ageValue
        lblSalary.text = salaryValue
    }
    
}
