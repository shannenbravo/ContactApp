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
    func didEditComany(company: Company)
}


class CreateCompanyController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var company: Company?{
        didSet{
            nameTextField.text = company?.name
            guard let founded = company?.founded else {return}
            datePicker.date = founded
            if let imageData = company?.imageData{
                companyPic.image = UIImage(data: imageData)
            }
        }
    }
    
    var delegate: CreateCompanyControllerDelegate?
    
    lazy var companyPic: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = iv.frame.width / 2
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        return iv
    }()
    
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
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.datePickerMode = .date
        return dp
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company == nil ? "Create Company" : "Edit Compnay"
    }

    override func viewDidLoad() {
       super.viewDidLoad()
        setupUI()
        navigationItem.title = "Add Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handelCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
         view.backgroundColor = .white

    }
    
    @objc private func handleSelectPhoto(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editiedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            companyPic.image = editiedImage
        }else if let orginalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            companyPic.image = orginalImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSave(){
        
        if company == nil{
            saveNewContact()
        }else{
            saveEditCompany()
        }
        
    }
    
    func saveEditCompany(){
        let context = CoreDataManager.shared.persistantContainer.viewContext
        company?.name = nameTextField.text
        if let contactImage = companyPic.image{
            let image = UIImageJPEGRepresentation(contactImage, 0.8)
            company?.imageData = image
        }
        do{
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditComany(company: self.company!)
            })

        }catch let saveErr{
            print("Error Updating Company: \(saveErr)")
            
        }
    }
    
    func saveNewContact(){
        //create comapny object from shared singlton
        let context = CoreDataManager.shared.persistantContainer.viewContext //need context to declare a comany
        //create our object
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        //set the value of the comany
        company.setValue(nameTextField.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        if let contactImage = companyPic.image{
            let image = UIImageJPEGRepresentation(contactImage, 0.8)
            company.setValue(image, forKey: "imageData")
        }
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
        let lightPinkBacgroundView = setupLightPinkBackground(height: 450)
        view.addSubview(companyPic)
        
        companyPic.topAnchor.constraint(equalTo: view.topAnchor, constant: 18).isActive = true
        companyPic.heightAnchor.constraint(equalToConstant: 100).isActive = true
        companyPic.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        companyPic.widthAnchor.constraint(equalToConstant: 100).isActive = true
        companyPic.layer.borderColor = UIColor.white.cgColor
        companyPic.layer.borderWidth = 2
       
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: companyPic.bottomAnchor, constant: 18).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true


        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: lightPinkBacgroundView.bottomAnchor).isActive = true

    }
}
