//
//  ComapniesControllers+CreateComany.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 6/4/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit

extension ViewController: CreateCompanyControllerDelegate {
    
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
    
}
