//
//  EmployeesController.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 6/4/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit
import CoreData

class IndentLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customRec = UIEdgeInsetsInsetRect(rect, insets)
        super.drawText(in: customRec)
    }
}

class EmployeesController: UITableViewController, CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee) {
        employees.append(employee)
        tableView.reloadData()
    }
    
    
    var company: Company?
    var employees = [Employee]()
    let cellid = "cellId"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        view.backgroundColor = .white
        setupPlusInNavBar(selector: #selector(handleAdd))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentLabel()
        if section == 0{
            label.text = "Short Names"
        }else if section == 1{
            label.text = "Long Names"
        }else{
            label.text = "Really Long Names"
        }
        label.backgroundColor = UIColor.pastelBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
//        let employee = employees[indexPath.row]
//        let employee = indexPath.section == 0 ? shortNameEmployee[indexPath.row] : longNameEmpolyee[indexPath.row]
        let employee = allEmployees[indexPath.section][indexPath.row]
        
        
        cell.backgroundColor = UIColor.pastelYellow
        cell.textLabel?.text = employee.name
        if let birthday = employee.employeeInformation?.birthdate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            
            cell.textLabel?.text = "\(employee.name ?? "")    \(dateFormatter.string(from: birthday))"
            
        }
//        if let taxId = employee.employeeInformation?.taxId {
//            cell.textLabel?.text = "\(employee.name ?? "")    \(taxId)"
//        }
//        cell.textLabel?.text = employee.name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees[section].count
    }
    
    var shortNameEmployee = [Employee]()
    var longNameEmpolyee = [Employee]()
    var reallyLonhEmoloyees = [Employee]()
    var allEmployees = [[Employee]]()
    
    func fetchData(){
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else {return}
        shortNameEmployee = companyEmployees.filter({ (employee) -> Bool in
            if let count = employee.name?.count{
                return count < 6
            }
            return false
        })
        
        longNameEmpolyee = companyEmployees.filter({ (employee) -> Bool in
            if let count = employee.name?.count{
                return count > 6 && count < 9
            }
            return false
        })
        
        reallyLonhEmoloyees = companyEmployees.filter({ (employee) -> Bool in
            if let count = employee.name?.count{
                return count > 9
            }
            
            return false
        })
//        self.employees = companyEmployees
        
        allEmployees = [
            shortNameEmployee,
            longNameEmpolyee,
            reallyLonhEmoloyees
        ]
        
    }
    
    
    @objc private func handleAdd(){
        let createEmployeeController = CreateEmployeeController()
        createEmployeeController.delegate = self
        createEmployeeController.company = self.company
        let navController = UINavigationController(rootViewController: createEmployeeController)
        present(navController, animated: true, completion: nil)
    }
}
