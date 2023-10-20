//
//  FifthViewController.swift
//  TrainingSwift
//
//  Created by ITBCA on 19/10/23.
//

import UIKit
import CoreData

class FifthViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataTable.dequeueReusableCell(withIdentifier: udIdentifier, for: indexPath) as! DataViewCell
        cell.setValue(idValue: userData[indexPath.row].id, nameValue: userData[indexPath.row].name, salaryValue: userData[indexPath.row].salary)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        create(Int(userData[indexPath.row].id), userData[indexPath.row].name, Int(userData[indexPath.row].salary))
        showEdit(Int(userData[indexPath.row].id), userData[indexPath.row].name, Int(userData[indexPath.row].salary))
        showDelete(Int(userData[indexPath.row].id), userData[indexPath.row].name, Int(userData[indexPath.row].salary))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteUser(userData[indexPath.row].id, userData[indexPath.row].name, Int(userData[indexPath.row].salary))
            self.dataTable.reloadData()
        }
    }
    
    @IBOutlet weak var dataTable: UITableView!
    
    let udIdentifier = "DataViewCell"
    var userData = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEntity()
        
        dataTable.delegate = self
        dataTable.dataSource = self
        
        dataTable.rowHeight = UITableView.automaticDimension
        dataTable.estimatedRowHeight = 216
        
        dataTable.register(UINib(nibName: "DataViewCell", bundle: nil),
                           forCellReuseIdentifier: udIdentifier)
    }

    @IBAction func btnAdd(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Employee", message: "Fill the form below", preferredStyle: .alert)
                
                alert.addTextField { tf in
                    tf.placeholder = "id"
                }
                
                alert.addTextField { tf in
                    tf.placeholder = "name"
                }
                
                alert.addTextField { tf in
                    tf.placeholder = "salary"
                }
                
                alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
                    if alert.textFields![0].text!.isEmpty || alert.textFields![1].text!.isEmpty{
                        let warning = UIAlertController(title: "Warning", message: "Fill all the textfield", preferredStyle: .alert)
                        warning.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                        self.present(warning, animated: true)
                    } else {
                        self.create(Int(alert.textFields![0].text!) ?? 0, alert.textFields![1].text!, Int(alert.textFields![2].text!) ?? 0)
        //                print(alert.textFields![0].text)
        //                print(alert.textFields![1].text)
                        
                        let success = UIAlertController(title: "Success", message: "Data added", preferredStyle: .alert)
                        success.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                        self.present(success, animated: true)
                        
                        
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
    }
    
    func create(_ id: Int, _ name: String, _ salary: Int){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: "UserData", in: managedContext)
            
            let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
            insert.setValue(id, forKey: "id")
            insert.setValue(name, forKey: "name")
            insert.setValue(salary, forKey: "salary")
            
            appDelegate.saveContext()
            dataTable.reloadData()
        }
        
        func fetchEntity(){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult> (
                entityName: "UserData"
            )
            
            do {
                let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
                
                result.forEach { employee in
                    userData.append(UserModel(id: employee.value(forKey: "id") as! Int, name: employee.value(forKey: "name") as! String, salary: employee.value(forKey: "salary") as! Int))
                }
            }catch let err {
                print(err)
            }
        }
        
    func showEdit(_ id: Int, _ name: String, _ salary: Int){
            let alert = UIAlertController(title: "Edit Employee", message: "Fill the form below", preferredStyle: .alert)
                    
                    alert.addTextField { tf in
                        tf.placeholder = "id"
                        tf.text = "\(id)"
                    }
                    
                    alert.addTextField { tf in
                        tf.placeholder = "name"
                        tf.text = "\(name)"
                    }
                    alert.addTextField { tf in
                        tf.placeholder = "salary"
                        tf.text = "\(salary)"
                    }
                    
                    alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
                        if alert.textFields![0].text!.isEmpty || alert.textFields![1].text!.isEmpty{
                            let warning = UIAlertController(title: "Warning", message: "Fill all the textfield", preferredStyle: .alert)
                            warning.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                            self.present(warning, animated: true)
                        } else {
                            self.editUser(Int(alert.textFields![0].text!) ?? 0, alert.textFields![1].text!, Int(alert.textFields![2].text!) ?? 0)
                            let success = UIAlertController(title: "Success", message: "Editted Successfuly", preferredStyle: .alert)
                            success.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                            self.present(success, animated: true)
                        }
                    }))
                    
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
        }
        
    func editUser(_ id: Int, _ name: String, _ salary: Int) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "UserData")
            fetchRequest.predicate = NSPredicate(format: "id = %d", id)
                    
            do {
                let fetch = try managedContext.fetch(fetchRequest)
                print(fetch[0])
                let dataToUpdate = fetch[0] as! NSManagedObject
                dataToUpdate.setValue(id, forKey: "id")
                dataToUpdate.setValue(name, forKey: "name")
                dataToUpdate.setValue(salary, forKey: "salary")
                appDelegate.saveContext()
                print(userData)
                dataTable.reloadData()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    
    func showDelete(_ id: Int, _ name: String, _ salary: Int){
        let alert = UIAlertController(title: "Delete Employee", message: "Are you sure?", preferredStyle: .alert)
                
                alert.addTextField { tf in
                    tf.placeholder = "id"
                    tf.text = "\(id)"
                }
                
                alert.addTextField { tf in
                    tf.placeholder = "name"
                    tf.text = "\(name)"
                }
                alert.addTextField { tf in
                    tf.placeholder = "salary"
                    tf.text = "\(salary)"
                }
                
                alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
                    if alert.textFields![0].text!.isEmpty || alert.textFields![1].text!.isEmpty{
                        let warning = UIAlertController(title: "Warning", message: "Fill all the textfield", preferredStyle: .alert)
                        warning.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                        self.present(warning, animated: true)
                    } else {
                        self.deleteUser(Int(alert.textFields![0].text!) ?? 0, alert.textFields![1].text!, Int(alert.textFields![2].text!) ?? 0)
                        let success = UIAlertController(title: "Success", message: "Delete Successfuly", preferredStyle: .alert)
                        success.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                        self.present(success, animated: true)
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
    }
    func deleteUser(_ id: Int, _ name: String, _ salary: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "UserData")
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
                
        do {
            let fetch = try managedContext.fetch(fetchRequest)
            print(fetch[0])
            let dataDoDelete = fetch[0] as! NSManagedObject
            managedContext.delete(dataDoDelete)
            
            try managedContext.save()
            print(userData)
            dataTable.reloadData()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    }

