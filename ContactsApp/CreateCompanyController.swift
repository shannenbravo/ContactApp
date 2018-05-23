//
//  CreateCompanyController.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 5/21/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate {
    func didAddComany(company: Company)
}



class CreateCompanyController: UIViewController{
    
    var delegate: CreateCompanyControllerDelegate?

    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
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

    override func viewDidLoad() {
       super.viewDidLoad()
        setupUI()
        navigationItem.title = "Add Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handelCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
         view.backgroundColor = .white

    }
    
    @objc private func handleSave(){

        //create comapny object from shared singlton
        let context = CoreDataManager.shared.persistantContainer.viewContext //need context to declare a comany
        //create our object
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        //set the value of the comany
        company.setValue(nameTextField.text, forKey: "name")
        //then actually save the object
        do{
            try context.save()
            
            //this block if for sucess so if the data is saved correctly
            dismiss(animated: true, completion: {
                self.delegate?.didAddComany(company: company as! Company)
                })
        }catch let saveErr{
            print("Failed to save caompany:", saveErr)
        }
        
    }

    @objc func handelCancel() {
        dismiss(animated: true, completion: nil)

    }

    private func setupUI() {
        let lightPinkBacgroundView = UIView()
        lightPinkBacgroundView.backgroundColor = .pastelGrey
        lightPinkBacgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lightPinkBacgroundView)
        lightPinkBacgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightPinkBacgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightPinkBacgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightPinkBacgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true

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
