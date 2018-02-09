//
//  ViewController.swift
//  MakeInventory
//
//  Created by Johnathan Chen on 2/5/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import UIKit
import CoreData
import BBBadgeBarButtonItem


protocol AddProductsControllerDelegate {
    func didAddProduct(product: Cart)
}

class AddProductsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: AddProductsControllerDelegate?
    
    var products = [Products]()
    var cartItems = [Cart]()
    var coreDataStack = CoreDataStack.instance
    
    
    var likeButtonToggle: Bool = false
    

    
    override func viewDidLoad() {
        
        let cartImage = UIImage(named: "cart")
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: nil, action: nil)
        
//        let carBarButton = BadgeBarButtonItem(image: "cart", target: nil, action: #selector(cartButtonTapped))!
//        self.navigationItem.rightBarButtonItem = carBarButton
//        let lastBarButton = rightBarButtons?.last

        
//
//        let cartBarButtonItem = BBBadgeBarButtonItem(customUIButton: customCartButton)
//        cartBarButtonItem?.badgeValue = "1"
//        cartBarButtonItem?.badgeTextColor = UIColor.white

        
        readJson()
    
    }
    
    
    
  
    
    @IBAction func addItemToCart(_ sender: UIButton) {
        
        let title = products[sender.tag].title
        let image = products[sender.tag].image
        let price = products[sender.tag].price
        
        // TODO: update cart UI to reflect saved data

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
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        likeButtonToggle = !likeButtonToggle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        
        cell.selectionStyle = .none
        
        cell.imageLabel.image = UIImage(named: product.image)
        cell.titleLabel.text = product.title
        cell.priceLabel.text = product.price
        cell.addButtonLabel.tag = indexPath.row

        
//        if cell.likeButtonLabel.isSelected == true {
//            cell.likeButtonLabel.setImage(#imageLiteral(resourceName: "selectedHeart"), for: .normal)
//        } else if cell.likeButtonLabel.isSelected == false {
//            cell.likeButtonLabel.setImage(#imageLiteral(resourceName: "unselectedHeart"), for: .normal)
//        }
        
        
        

        
        return cell
    }
    

    
    
    
 
    
    
    
    
}


