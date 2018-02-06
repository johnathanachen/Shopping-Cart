//
//  ViewController.swift
//  MakeInventory
//
//  Created by Johnathan Chen on 2/5/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import UIKit
import CoreData

class AddProductsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var products = [Products]()
    var cartItem = [Cart]()
    
    var selectedImage = ""
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    let images = [#imageLiteral(resourceName: "ultraboost"),#imageLiteral(resourceName: "prophere"),#imageLiteral(resourceName: "eqt"),#imageLiteral(resourceName: "AlphaBounce"),#imageLiteral(resourceName: "Dame4"),#imageLiteral(resourceName: "Primeknit")]
    
    override func viewDidLoad() {
        readJson()
    }
    
    @IBAction func addToCartButton(_ sender: UIButton) {
        addProduct()
    }
    
    func addProduct() {
        print("Trying to save product")
        
        let context = CoreDataStack.shared.presistentContainer.viewContext
        
        let cartProduct = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: context)
        
        
        cartProduct.setValue(selectedImage, forKey: "image")
        cartProduct.setValue(titleLabel.text, forKey: "title")
        cartProduct.setValue(priceLabel.text, forKey: "price")
        cartProduct.setValue(1, forKey: "quantity")
        
        // Perform Save
        do {
            try context.save()
        } catch let saveError {
            print("Error saving \(saveError)")
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
        selectedImage = product.image
        cell.titleLabel.text = product.title
        cell.priceLabel.text = product.price
        
        return cell
    }
    
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
}


