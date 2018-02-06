//
//  CoreDataStack.swift
//  MakeInventory
//
//  Created by Johnathan Chen on 2/5/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import Foundation
import CoreData

public final class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let presistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MakeInventory")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading persistent store failed: \(error)")
            }
        }
        return container
    }()
}

