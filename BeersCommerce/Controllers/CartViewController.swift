//
//  CartViewController.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 29/12/21.
//

import UIKit
import Firebase

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cartListFirebase: DatabaseReference = Database.database().reference().child("cartlist")
    
    var cart: [CartItem] = []
    
    @IBOutlet weak var cartTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTable.delegate = self
        cartTable.dataSource = self
        
        userCart!.observe(.value) { snapshot in
            
            self.cart = []
            
            for item in snapshot.children {
                
                let cartData = item as! DataSnapshot
                let cartItem = cartData.value as! [String: Any]
                
                if cartItem["quantity"]! as! String != "0" {
                    self.cart.append(CartItem(id: String(describing: cartItem["id"]!), name: String(describing: cartItem["name"]!), quantity: String(describing: cartItem["quantity"]!)))
                }
            }
            self.cartTable.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)
        
        cell.textLabel?.text = cart[indexPath.row].name
        cell.detailTextLabel?.text = cart[indexPath.row].quantity
        
        return cell
    }
}
