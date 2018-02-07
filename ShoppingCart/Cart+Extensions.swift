//
//  Cart+Extensions.swift
//  ShoppingCart
//
//  Created by Johnathan Chen on 2/6/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import Foundation
import CoreData

extension Cart {
    convenience init(context: NSManagedObjectContext) {

        let entityDescription = NSEntityDescription.entity(forEntityName: "Cart", in:
            context)!

        self.init(entity: entityDescription, insertInto: context)
    }
}

