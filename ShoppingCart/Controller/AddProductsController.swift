//
//  ViewController.swift
//  MakeInventory
//
//  Created by Johnathan Chen on 2/5/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import UIKit
import CoreData

protocol AddProductsControllerDelegate {
    func didAddProduct(product: Cart)
}

class AddProductsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: AddProductsControllerDelegate?
    
    var products = [Products]()
    var cartItems = [Cart]()
    var coreDataStack = CoreDataStack.instance
    
    override func viewDidLoad() {
        readJson()
    }
    
    @IBAction func addItemToCart(_ sender: UIButton) {
        
        let title = products[sender.tag].title
        let image = products[sender.tag].image
        let price = products[sender.tag].price
        
        
        
        // TODO: check if item already exist
        // fetch context
        // check if item already exist
        // change quanity and save context if item exist
//        let selected = coreDataStack.viewContext.object(with: item.objectID)
        
        let fetch = NSFetchRequest<Cart>(entityName: "Cart")
        let pred = NSPredicate(format: "title == %@", title)
        fetch.predicate = pred
        
        do {
            let result = try coreDataStack.viewContext.fetch(fetch)
            if result.first?.title == title {
                result.first?.quantity += Int32(1)
                print(result.first?.quantity)
                coreDataStack.saveTo(context: coreDataStack.viewContext)
            }
            if result.first?.title != title {
                let item = Cart(context: coreDataStack.privateContext)
                item.title = title
                item.image = image
                item.price = price
                item.quantity = Int32(1)
                coreDataStack.saveTo(context: coreDataStack.privateContext)
            }
        } catch let error {
            print(error)
        }
        
    }
    
    func readJson() {
        do {
            let path = Bundle.main.path(forResource: "products", ofType: "json")
            let jsonURL = URL(fileURLWithPath: path!)
            let jsonDecoder = JSONDecoder()
            let savedJSONData = try Data(contentsOf: jsonURL)
            let jsonDisplay = try jsonDecoder.decode([Products].self, from: savedJSONData)
            
            self.products = jsonDisplay
            
        } catch {print(error)}
    }
    
    struct Products: Codable {
        var title: String
        var image: String
        var price: String
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        
        cell.imageLabel.image = UIImage(named: product.image)
        cell.titleLabel.text = product.title
        cell.priceLabel.text = product.price
        cell.addButtonLabel.tag = indexPath.row
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    

    
    
    
 
    
    
    
    
}


