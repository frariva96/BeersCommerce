//
//  BeerTableViewCell.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 28/12/21.
//

import UIKit
import Firebase

var cartQuantity: Int?

class BeerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerTitle: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var beerAbv: UILabel!
    @IBOutlet weak var beerIbu: UILabel!
    @IBOutlet weak var cartQuantityLabel: UILabel!
    
    
    @IBAction func cartMinusAction(_ sender: UIButton) {
        
        cartQuantity = Int(cartQuantityLabel.text!)! - 1
        userCart!.child(beerTitle.text!).updateChildValues(["quantity": cartQuantity! ])
    }
    
    @IBAction func cartPlusAction(_ sender: UIButton) {
        
        cartQuantity = Int(cartQuantityLabel.text!)! + 1
        userCart!.child(beerTitle.text!).updateChildValues(["quantity": cartQuantity! ])
    }
}
