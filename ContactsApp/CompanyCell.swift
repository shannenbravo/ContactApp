//
//  CompanyCell.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 6/4/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit


class CompanyCell: UITableViewCell {
    
    var company: Company?{
        
        didSet{
            nameFoundedDate.text = company?.name
            if let imageData = company?.imageData{
                companyImage.image = UIImage(data: imageData)
            }
            
            if let name = company?.name, let founded = company?.founded {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                let foundedDateString = dateFormatter.string(from: founded)
                let dateSrting = "\(name) - Founded: \(foundedDateString)"
                nameFoundedDate.text = dateSrting
                
            }else {
                nameFoundedDate.text = company?.name
            }

        }
    }
    
    let companyImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 1 
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameFoundedDate: UILabel = {
        let label = UILabel()
        label.text = "Comany"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.pastelYellow
        addSubview(companyImage)
        companyImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        companyImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        companyImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        companyImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(nameFoundedDate)
//        nameFoundedDate.leftAnchor.constraint(equalTo: companyImage.rightAnchor).isActive = true
        nameFoundedDate.leftAnchor.constraint(equalTo: companyImage.rightAnchor, constant: 8).isActive = true
        nameFoundedDate.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        nameFoundedDate.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        nameFoundedDate.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
