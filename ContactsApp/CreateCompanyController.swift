//
//  CreateCompanyController.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 5/21/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController{
    override func viewDidLoad() {
       super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Add Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handelCancel))
    }
    
    @objc func handelCancel() {
        dismiss(animated: true, completion: nil)
        
    }
}

