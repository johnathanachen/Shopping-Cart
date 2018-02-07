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
    var coreDataStack = CoreDataStack.instance

    
    override func viewDidLoad() {
        readJson()
    }
    
    @IBAction func addItemToCart(_ sender: UIButton) {
        
        let title = products[sender.tag].title
        let image = products[sender.tag].image
        let price = products[sender.tag].price
        let quantity = 1
        print(title)
        print(image)
        print(price)
        
//        let item = Cart(context: coreDataStack.privateContext)
//        item.title = title
//        item.image = image
//        item.price = price
//        item.quantity = Int32(quantity)
//
//        coreDataStack.saveTo(context: coreDataStack.privateContext)
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
        
        return cell
    }
    
    
    
 
    
    
    
    
}


