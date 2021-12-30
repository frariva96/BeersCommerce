//
//  CartItem.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 29/12/21.
//

import Foundation

class CartItem {
    
    var id: String
    var name: String
    var quantity: Int
    
    init(id: String, name: String, quantity: Int) {
        self.id = id
        self.name = name
        self.quantity = quantity
    }
}
