//
//  CartController.swift
//  MakeInventory
//
//  Created by Johnathan Chen on 2/5/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import UIKit
import CoreData

class CartController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate, AddProductsControllerDelegate {
    
    var stack = CoreDataStack.instance
    
    var cartItem = [Cart]()

    let tableview = UITableView()
    
    func didAddProduct(product: Cart) {
        cartItem.append(product)
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Perform fetch from Core Data
        let fetchRequest = NSFetchRequest<Cart>(entityName: "Cart")
        
        do {
            let result = try stack.viewContext.fetch(fetchRequest)
            self.cartItem = result
        } catch let error {
            print(error)
        }
    }
    
    override func viewDidLoad() {
       self.tabBarController?.delegate = self
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
        
        cell.cartImageView.image = UIImage(named: cartItem.image!)
        cell.titleLabel.text = cartItem.title
        cell.priceLabel.text = cartItem.price
        cell.quantityLabel.text = String(cartItem.quantity)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
        
    }
    // TODO: update page when clicked
    
    // Delete items
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            let item = self.cartItem[indexPath.row]
            self.cartItem.remove(at: indexPath.row)
            self.tableview.deleteRows(at: [indexPath], with: .automatic)
            
            let context = self.stack.viewContext
            context.delete(item)
            
            do {
                try context.save()
                tableView.reloadData()
            } catch let deleteError {
                print("Failed to delete cart item", deleteError)
            }
        }
        return [deleteAction]
    }
    
    
    
}
