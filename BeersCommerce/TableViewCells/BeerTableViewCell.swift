//
//  BeerTableViewCell.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 28/12/21.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerTitle: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var beerAbv: UILabel!
    @IBOutlet weak var beerIbu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
