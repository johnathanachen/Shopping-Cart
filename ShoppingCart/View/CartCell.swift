//
//  CartCell.swift
//  ShoppingCart
//
//  Created by Johnathan Chen on 2/6/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var addMoreToCart: UIButton!
    @IBOutlet weak var removeItemFromCart: UIButton!
    
    

}
