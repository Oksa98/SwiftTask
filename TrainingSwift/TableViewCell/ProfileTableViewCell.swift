//
//  ProfileTableViewCell.swift
//  TrainingSwift
//
//  Created by ITBCA on 18/10/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setValue(type: ProfileType, value: String){
        title.text = type.rawValue
        Description.text = value
        
        if type == ProfileType.bio {
            Description.numberOfLines = 0
        } else {
            Description.numberOfLines = 1
        }
    }
    
}
