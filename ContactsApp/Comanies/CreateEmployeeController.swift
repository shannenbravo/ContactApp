//
//  CreateEmployeeController.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 6/4/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit

let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Name"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label;
}()

let nameTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Enter Name"
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
}()

class CreateEmployeeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCancelButton()
        navigationItem.title =  "Create Employee"
        _ = setupLightPinkBackground(height: 50)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        setupUI()
    }
    
    @objc func handleSave(){
        guard let emplyeeName = nameTextField.text else {return}
        let err = CoreDataManager.shared.saveEmployee(name: emplyeeName)
        if let err = err{
            print(err)
        }else{
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func setupUI() {
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
    }
}
