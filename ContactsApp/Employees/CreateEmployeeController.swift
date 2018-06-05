//
//  CreateEmployeeController.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 6/4/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit

protocol CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee)
}

class CreateEmployeeController: UIViewController {
    
    var delegate: CreateEmployeeControllerDelegate?
    var company: Company?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label;
    }()
    
    let bdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Birthday"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label;
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let bdayTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "MM/DD/YYYY"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCancelButton()
        navigationItem.title =  "Create Employee"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        setupUI()
    }
    
    @objc func handleSave(){
        guard let emplyeeName = nameTextField.text else {return}
        guard let company = self.company else {return}
        //lets turn birthaay into a date object
        guard let birthdayText = bdayTextField.text else {return}
        if birthdayText.isEmpty {
            showError(title: "No Birthday entered", message: "Please enter a birthday")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        guard let birthdayDate  = dateFormatter.date(from: birthdayText) else {
            showError(title: "Bad Format", message: "birthday Not Vlaid")
            return
        }
        let tuple = CoreDataManager.shared.saveEmployee(name: emplyeeName, birthday: birthdayDate, company: company)
        if let err = tuple.1{
            print(err)
        }else{
            dismiss(animated: true, completion: {
                // we'll call the delegate somehow
                self.delegate?.didAddEmployee(employee: tuple.0!)
            })
//            dismiss(animated: true, completion: nil)
        }
        
    }
    
    private func showError (title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func setupUI() {
         _ = setupLightPinkBackground(height: 100)
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(bdayLabel)
        bdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        bdayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        bdayLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        bdayLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
        view.addSubview(bdayTextField)
        bdayTextField.leftAnchor.constraint(equalTo: bdayLabel.rightAnchor).isActive = true
        bdayTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bdayTextField.bottomAnchor.constraint(equalTo: bdayLabel.bottomAnchor).isActive = true
        bdayTextField.topAnchor.constraint(equalTo: bdayLabel.topAnchor).isActive = true
    }
}
