//
//  ViewController.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 5/18/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController, CreateCompanyControllerDelegate {

    func didAddComany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        
    }
    var companies = [Company]()
//    var companies = [
//        Company(name: "SpaceX", founded: Date()),
//        Company(name: "Tesla", founded: Date())
//    ]'
    
    private func fetchCompanies(){
        let persistantcontainer = NSPersistentContainer(name: "IntermediateTraningModels")
        
        //load persistant stores
        persistantcontainer.loadPersistentStores { (storeDescription, err) in
            if let err = err{
                fatalError("Loding of store failer: \(err)")
            }
        }
        
        //create comapny object
        let context = persistantcontainer.viewContext //need context to declare a comany
        
        ///make te fecth request
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            
            companies.forEach({ (company) in
                print(company.name ?? "")
                 })
            }catch let fetchErr {
                 print("Failed to fetch companies:", fetchErr)
            }
        
        }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchCompanies()
        view.backgroundColor = .white
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon 2").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddContact))
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView();
    }


    @objc func handleAddContact (){
        print("Adding Contact")
        let createCompanyController = CreateCompanyController();
        let navController = costumNavigateBar(rootViewController: createCompanyController)
        createCompanyController.delegate = self
        present(navController, animated: true, completion: nil)

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = .pastelGrey
        let company = companies[indexPath.row].name
        cell.textLabel?.text = company
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView();
        view.backgroundColor = .lightGray
        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }



}








