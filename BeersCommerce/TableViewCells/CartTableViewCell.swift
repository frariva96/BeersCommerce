//
//  CartTableViewCell.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 30/12/21.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    @IBAction func cartMinusAction(_ sender: UIButton) {
        
        //cartQuantity = Int(cartQuantityLabel.text!)! - 1
        //userCart!.child(beerTitle.text!).updateChildValues(["quantity": cartQuantity! ])
    }
    
    @IBAction func cartPlusAction(_ sender: UIButton) {
        
        //cartQuantity = Int(cartQuantityLabel.text!)! + 1
        //userCart!.child(beerTitle.text!).updateChildValues(["quantity": cartQuantity! ])
    }
    

}
