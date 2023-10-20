//
//  ThridViewController.swift
//  TrainingSwift
//
//  Created by ITBCA on 18/10/23.
//

import UIKit

class ThridViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell =
        tableView.dequeueReusableCell(withIdentifier: profileCell, for: indexPath) as!
        ProfileTableViewCell
        
        let cellData: [(ProfileType, String)] = [
            (profileTypeOrder[0], dataProfile.name),
            (profileTypeOrder[1], dataProfile.job),
            (profileTypeOrder[2], String(dataProfile.age)),
            (profileTypeOrder[3], dataProfile.bio)]
        
        cell.setValue(type: cellData[indexPath.row].0,
                      value: cellData[indexPath.row].1)
        return cell
    }
    

    private let profileCell = "ProfileCell"

    
    @IBOutlet weak var tableView: UITableView!
    
    let dataProfile = Profile(
        name: "Okta Saputra",
        job: "IOS Developer",
        age: 25,
        bio: "I'm an IOS Developer in IT BCA")
    
    let profileTypeOrder = [
        ProfileType.name,
        ProfileType.job,
        ProfileType.age,
        ProfileType.bio]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
        UINib(nibName: "ProfileTableViewCell", bundle: nil),
        forCellReuseIdentifier: profileCell
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }

}
