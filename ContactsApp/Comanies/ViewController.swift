//
//  ViewController.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 5/18/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

    var companies = [Company]()

    
    private func fetchCompanies(){
        
        //create comapny object
        let context = CoreDataManager.shared.persistantContainer.viewContext //need context to declare a comany
        
        ///make te fecth request
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            
            companies.forEach({ (company) in
                print(company.name ?? "")
                 })
            self.companies = companies //set ur ouside array equal to this functions comapies
            self.tableView.reloadData() //reload the data on the table cuz we just fetched new data
            
            }catch let fetchErr {
                 print("Failed to fetch companies:", fetchErr)
            }
        
        }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchCompanies()
        view.backgroundColor = .white
        navigationItem.title = "Companies"
        setupPlusInNavBar(selector:  #selector(handleAddContact))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        tableView.backgroundColor = .white
        tableView.register(CompanyCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
    }
    
    @objc func handleReset(){
        let context = CoreDataManager.shared.persistantContainer.viewContext
        //make batch delete request
        let deleteBatchRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        do{
            try context.execute(deleteBatchRequest)
            
            var indexPathToRemove = [IndexPath]()
            for(index, _) in companies.enumerated(){
                let indexPath = IndexPath(row: index, section: 0)
                indexPathToRemove.append(indexPath)
            }
            companies.removeAll()
            tableView.deleteRows(at: indexPathToRemove, with: .left)
        
        }catch let delErr{
            print("Cannnot reset", delErr)
        }
    }


    @objc func handleAddContact (){
        print("Adding Contact")
        let createCompanyController = CreateCompanyController();
        let navController = costumNavigateBar(rootViewController: createCompanyController)
        createCompanyController.delegate = self
        present(navController, animated: true, completion: nil)

    }


}








