//
//  ProductCell.swift
//  ShoppingCart
//
//  Created by Johnathan Chen on 2/5/18.
//  Copyright © 2018 JCSwifty. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButtonLabel: UIButton!
    @IBOutlet weak var likeButtonLabel: UIButton! {
        didSet {
            likeButtonLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleHeartSelection)))
        }
    }
    
     var likeButtonToggle: Bool = false
    
    @objc private func handleHeartSelection() {
        print("pressed")
//        likeButtonLabel.setImage(#imageLiteral(resourceName: "selectedHeart"), for: .normal)
        likeButtonLabel.setImage(UIImage(named:(likeButtonToggle ? "selectedHeart" : "unselectedHeart")), for: .normal)
        likeButtonToggle = !likeButtonToggle
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    

}
