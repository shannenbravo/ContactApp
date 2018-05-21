//
//  ViewController.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 5/18/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
//        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView();
    }
    
    func setupNavBar(){
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.barTintColor = UIColor.pastelGrey
        navigationController?.navigationBar.prefersLargeTitles = true;
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon 2").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddContact))
        
    }
    
    @objc func handleAddContact (){
        print("Adding Contact")
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.text = "TESTING"
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView();
        view.backgroundColor = .pastelYellow;
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50 
    }



}

