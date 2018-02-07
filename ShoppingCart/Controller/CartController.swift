//
//  CartController.swift
//  MakeInventory
//
//  Created by Johnathan Chen on 2/5/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import UIKit
import CoreData

class CartController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cartItem = [Cart]()
    
    // Perform fetch
    
    private func fetchProductsAddedToCart() {
        
        let context = CoreDataStack.shared.presistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Cart>(entityName: "Cart")
        
        do {
            let cartItems = try context.fetch(fetchRequest)
            cartItems.forEach({ (item) in
                print(item.title ?? "")
            })
        } catch let fetchingError {
            print("Error fetching core data: \(fetchingError)")
        }
        
    }
    
    override func viewDidLoad() {
//        fetchProductsAddedToCart()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        let cartItem = self.cartItem[indexPath.row]
        
        
        
        
        return cell
        
    }
}
