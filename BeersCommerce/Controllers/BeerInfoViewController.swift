//
//  BeerInfoViewController.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 28/12/21.
//

import UIKit

class BeerInfoViewController: UIViewController {
    
    var beer: Beer?
    
    @IBOutlet weak var firstBrewedLabel: UILabel!
    @IBOutlet weak var foodPairingLabel: UILabel!
    @IBOutlet weak var brewersTipsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstBrewedLabel.text = beer?.brewersTips
        
        
        var result: String = ""
        
        for el in beer!.foodPairing {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint)\(el)\n"
            result = result + formattedString
        }
        
        
        foodPairingLabel.text = result

        print(beer?.brewersTips)
        
        brewersTipsLabel.text = beer?.firstBrewed
     
    }
    

  

}
