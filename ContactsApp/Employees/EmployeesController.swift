//
//  EmployeesController.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 6/4/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit
import CoreData

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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        let employee = employees[indexPath.row]
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
        return employees.count
    }
    
    func fetchData(){
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else {return}
        self.employees = companyEmployees
        
    }
    
    
    @objc private func handleAdd(){
        let createEmployeeController = CreateEmployeeController()
        createEmployeeController.delegate = self
        createEmployeeController.company = self.company
        let navController = UINavigationController(rootViewController: createEmployeeController)
        present(navController, animated: true, completion: nil)
    }
}
