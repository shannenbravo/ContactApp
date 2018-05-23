//
//  CoreDataManager.swift
//  ContactsApp
//
//  Created by Shannen Bravo-Brown on 5/23/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    let persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "IntermediateTraningModels")
        container.loadPersistentStores(completionHandler: { (storeDescription, err) in
            if let err = err{
                fatalError("Loading Store failed: \(err)")
            }
        })
        
        return container
    }()
    
}
