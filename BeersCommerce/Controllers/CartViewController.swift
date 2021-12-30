//
//  CartViewController.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 29/12/21.
//

import UIKit
import Firebase

var tot: Int? = 0
class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cartListFirebase: DatabaseReference = Database.database().reference().child("cartlist")
    
    var cart: [CartItem] = []
    
    @IBOutlet weak var cartTable: UITableView!
    @IBOutlet weak var cartTabBar: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTable.delegate = self
        cartTable.dataSource = self
        //navigationController?.navigationBar.isHidden = true
        
        userCart!.observe(.value) { snapshot in
            
            self.cart = []
            tot = 0
            
            for item in snapshot.children {
                
                let cartData = item as! DataSnapshot
                let cartItem = cartData.value as! [String: Any]
                
                if cartItem["quantity"] as! Int > 0 {
                    self.cart.append(CartItem(id: String(describing: cartItem["id"]!), name: String(describing: cartItem["name"]!), quantity: cartItem["quantity"] as! Int))
                    
                    tot! += cartItem["quantity"] as! Int
                }
            }
            self.cartTabBar.badgeValue = String(tot!)
            self.cartTable.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)
        
        cell.textLabel?.text = cart[indexPath.row].name
        cell.detailTextLabel?.text = String(cart[indexPath.row].quantity)
        
        return cell
    }
}
