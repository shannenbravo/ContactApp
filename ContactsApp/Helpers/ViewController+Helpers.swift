//
//  ViewController+Helpers.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 6/4/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func setupPlusInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon 2"), style: .plain, target: self, action: selector)
    }
    
    func setupCancelButton(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModal))
    }
    
    @objc func handleCancelModal(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupLightPinkBackground(height: CGFloat) -> UIView {
        
        let lightPinkBacgroundView = UIView()
        lightPinkBacgroundView.backgroundColor = .pastelGrey
        lightPinkBacgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lightPinkBacgroundView)
        lightPinkBacgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightPinkBacgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightPinkBacgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightPinkBacgroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return lightPinkBacgroundView
    }

}
