//
//  CartController.swift
//  MakeInventory
//
//  Created by Johnathan Chen on 2/5/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import UIKit
import CoreData

class CartController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITabBarControllerDelegate, AddProductsControllerDelegate {
    
    var stack = CoreDataStack.instance
    
    var cartItem = [Cart]() {
        didSet {
            cartTableView.reloadData()
        }
    }

    let tableview = UITableView()
    
    func didAddProduct(product: Cart) {
        cartItem.append(product)
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreData()
    }
    
    func fetchCoreData() {
        // Perform fetch from Core Data
        let fetchRequest = NSFetchRequest<Cart>(entityName: "Cart")
        
        do {
            let result = try stack.viewContext.fetch(fetchRequest)
            self.cartItem = result
        } catch let error {
            print(error)
        }
    }
    
    @IBOutlet weak var cartTableView: UITableView!
    override func viewDidLoad() {
        self.tabBarController?.delegate = self
    }
    
    // TODO: edt quantiy amount then save to core data
    @IBAction func addMoreItems(_ sender: UIButton) {
        let title = cartItem[sender.tag].title
        
        let fetch = NSFetchRequest<Cart>(entityName: "Cart")
        let pred = NSPredicate(format: "title == %@", title!)
        fetch.predicate = pred
        
        do {
            let result = try stack.viewContext.fetch(fetch)
            result.first?.quantity += Int32(1)
            print(result.first?.quantity)
            
 
        } catch let error {
            print(error)
        }
        stack.saveTo(context: stack.viewContext)
        cartTableView.reloadData()
    }
    
    @IBAction func removeMoreItems(_ sender: UIButton) {
        let title = cartItem[sender.tag].title
        
        let fetch = NSFetchRequest<Cart>(entityName: "Cart")
        let pred = NSPredicate(format: "title == %@", title!)
        fetch.predicate = pred
        
        do {
            let result = try stack.viewContext.fetch(fetch)
            result.first?.quantity -= Int32(1)
            print(result.first?.quantity)
        } catch let error {
            print(error)
        }
        stack.saveTo(context: stack.viewContext)
        cartTableView.reloadData()
    }

    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No items in cart..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return cartItem.count == 0 ? 150 : 0
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
        
        cell.addMoreToCart.tag = indexPath.row
        cell.removeItemFromCart.tag = indexPath.row
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
        
    }
    
    
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
    
    // update page bar button item clicked
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            cartTableView.reloadData()
        }
    }
    
    
    
}
