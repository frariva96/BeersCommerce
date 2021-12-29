//
//  BeerTableViewCell.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 28/12/21.
//

import UIKit
import Firebase

var cartQuantity: String?

class BeerTableViewCell: UITableViewCell {
    
    var cartlistFirebase: DatabaseReference = Database.database().reference().child("cartlist")
    
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerTitle: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var beerAbv: UILabel!
    @IBOutlet weak var beerIbu: UILabel!
    @IBOutlet weak var cartQuantityLabel: UILabel!
    @IBOutlet weak var idBeerLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func cartMinusAction(_ sender: UIButton) {
        
        cartQuantity = String(Int(cartQuantityLabel.text!)! - 1)
        
        cartQuantityLabel.text = cartQuantity!
        
        print(cartQuantity!)
        print(idBeerLabel.text!)
        
        
        cartlistFirebase.child(beerTitle.text!).updateChildValues(["idBeer": idBeerLabel.text!, "name": beerTitle.text!, "quantity": cartQuantity! ])
        
        
    }
    
    
    @IBAction func cartPlusAction(_ sender: UIButton) {
        
        cartQuantity = String(Int(cartQuantityLabel.text!)! + 1)
        
        cartQuantityLabel.text = cartQuantity!
        
        print(cartQuantity!)
        print(idBeerLabel.text!)
        
        cartlistFirebase.child(beerTitle.text!).updateChildValues(["idBeer": idBeerLabel.text!, "name": beerTitle.text!, "quantity": cartQuantity! ])
        
    }
    
    
    
}
