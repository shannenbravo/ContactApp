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
    func didEditComany(company: Company) {
        let row = companies.index(of: company)
        let reloadPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadPath], with: .middle)
    }
    

    func didAddComany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        
    }
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
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            let comany = self.companies[indexPath.row]
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            let context = CoreDataManager.shared.persistantContainer.viewContext
            context.delete(comany)
            do{
                try context.save()
            }catch let saveErr{
                print("Issue saving: ", saveErr)
            }
        }
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)

        
        return [deleteAction, editAction]
    }
    
    private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath){
        let editComanyController = CreateCompanyController()
        editComanyController.delegate = self
        editComanyController.company = companies[indexPath.row]
        let navController = costumNavigateBar(rootViewController: editComanyController)
        present(navController, animated: true, completion: nil)
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
        let company = companies[indexPath.row]
        if let name = company.name, let founded = company.founded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let foundedDateString = dateFormatter.string(from: founded)
            let dateSrting = "\(name) - Founded: \(foundedDateString)"
            cell.textLabel?.text = dateSrting
            
        }else {
            cell.textLabel?.text = company.name
        }
//        cell.textLabel?.text = company
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








