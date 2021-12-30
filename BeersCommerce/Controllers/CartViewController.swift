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
    
    //var cartListFirebase: DatabaseReference = Database.database().reference().child("cartlist")
    
    var cart: [CartItem] = []
    
    @IBOutlet weak var cartTable: UITableView!
    @IBOutlet weak var cartTabBar: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .lightGray
            tabBarController?.tabBar.standardAppearance = appearance
            tabBarController?.tabBar.scrollEdgeAppearance = tabBarController?.tabBar.standardAppearance
        }
        
        
        cartTable.delegate = self
        cartTable.dataSource = self
        //navigationController?.navigationBar.isHidden = true
        loadCartBeers()
    }
    
    func loadCartBeers() {
        userCart = Database.database().reference().child("cartUser").child(userGlobal!)
        userCart!.observe(.value) { snapshot in
            
            self.cart = []
            tot = 0
            
            for item in snapshot.children {
                
                let cartData = item as! DataSnapshot
                let cartItem = cartData.value as! [String: Any]
                
                if cartItem["quantity"] as! Int > 0 {
                    
                    let i = CartItem(
                        id: String(describing: cartItem["id"]!),
                        name: String(describing: cartItem["name"]!),
                        imageUrl: String(describing: cartItem["imageUrl"]!),
                        quantity: cartItem["quantity"] as! Int)
                    
                    self.cart.append(i)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        
        cell.beerTitle.text = cart[indexPath.row].name
        
        if let url = NSURL(string: cart[indexPath.row].imageUrl) {
            
             DispatchQueue.global(qos: .default).async{
                 if let data = NSData(contentsOf: url as URL) {
                     DispatchQueue.main.async {
                         cell.beerImage.image = UIImage(data: data as Data)
                     }
                 }
             }
         }
        return cell
    }
}
