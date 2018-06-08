//
//  CoreDataManager.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 5/23/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    let persistantContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "IntermediateTraningModels")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, err) in
            if let err = err{
                fatalError("Loading Store failed: \(err)")
            }
        })
        return container
    }()
    
    func saveEmployee(name: String, employeeType: String, birthday: Date, company: Company) -> (Employee?, Error?) {
        let context = persistantContainer.viewContext
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        employee.setValue(name, forKey: "name")
        
        employee.company = company
        employee.type = employeeType
        let employeeInformation = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInformation", into: context) as! EmployeeInformation
        
        employeeInformation.taxId = "456"
        employeeInformation.birthdate = birthday
        
        employee.employeeInformation = employeeInformation
        
        do{
            try context.save()
            return (employee,nil)
            
        }catch let err{
            print("fail to create employee", err)
            return (nil,err)
        }
    }
}
