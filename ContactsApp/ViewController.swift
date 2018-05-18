//
//  ViewController.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 5/18/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = .purple
    }
    
    func setupNavBar(){
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true;
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
    }



}

