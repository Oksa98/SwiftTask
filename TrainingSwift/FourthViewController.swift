//
//  FourthViewController.swift
//  TrainingSwift
//
//  Created by ITBCA on 18/10/23.
//

import UIKit

class FourthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var apiResult : Wrapper = Wrapper(data: [])
    
    @IBOutlet weak var dataFromAPITable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFetchHandler.sharedInstance.fetchAPIData{
            apiData in self.apiResult = apiData
            self.dataFromAPITable.reloadData()
        }
        
        dataFromAPITable.register(UINib(nibName: "EmployeesTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeesCell")
        
        dataFromAPITable.dataSource = self
        dataFromAPITable.delegate = self
        
        dataFromAPITable.rowHeight = UITableView.automaticDimension
        dataFromAPITable.estimatedRowHeight = 500
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiResult.data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataFromAPITable.dequeueReusableCell(withIdentifier: "EmployeesCell", for: indexPath) as!
            EmployeesTableViewCell
        
//        cell.lblName.text = apiResult.data[indexPath.row].employee_name
//        
//        cell.lblAge.text = String(apiResult.data[indexPath.row].employee_age)
//        
//        cell.lblSalary.text = String(apiResult.data[indexPath.row].employee_salary)
        
        cell.setValue(nameValue: apiResult.data[indexPath.row].employee_name,
                      ageValue: String(apiResult.data[indexPath.row].employee_age),
                      salaryValue: String(apiResult.data[indexPath.row].employee_salary))
        
        return cell
    }
    
    func success (apiResult: Wrapper){
        self.apiResult = apiResult
        self.dataFromAPITable.reloadData()
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
