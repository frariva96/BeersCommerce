//
//  CartViewController.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 29/12/21.
//

import UIKit
import Firebase
import MessageUI
import SafariServices

var tot: Int? = 0
class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    //var cartListFirebase: DatabaseReference = Database.database().reference().child("cartlist")
    
    var cart: [CartItem] = []
    
    @IBOutlet weak var cartTable: UITableView!
    @IBOutlet weak var cartTabBar: UITabBarItem!
    @IBOutlet weak var totalPiecesLabel: UILabel!
    
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
        
        totalPiecesLabel.text = String(tot!)
        
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
                    self.totalPiecesLabel.text = String(tot!)
                }
            }
            self.cartTabBar.badgeValue = String(tot!)
            self.totalPiecesLabel.text = String(tot!)
            self.cartTable.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        
        cell.beerTitle.text = cart[indexPath.row].name
        cell.quantityLabel.text = String(cart[indexPath.row].quantity)
        
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
    
    
    @IBAction func sendOrdeAction(_ sender: UIButton) {
        //performSegue(withIdentifier: "cartTOsendEmail", sender: cart)
        sendEmail(recipient: emailUser!, text: composeTextMail())
        clearCart()
        
    }
    
    
    func sendEmail(recipient: String, text: String){
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipient])
            mail.setMessageBody(text, isHTML: false)
            mail.setSubject("BEERS CART")
            
            present(mail, animated: true, completion: nil)
        }else{
            guard let url = URL(string: "https://www.google.com") else {
                return
            }
            let vc = SFSafariViewController(url: url)
            
            present(vc, animated: true)
            
        }
    }
    

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func composeTextMail() -> String {
        var result: String = ""
        var totBeers = 0
        
        for el in cart {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint)\(el.name) x \(el.quantity)\n"
            result = result + formattedString
            totBeers += el.quantity
        }
        
        result += "\n Total pieces: \(totBeers)"
        
        return result
    }
    
    func clearCart() {
        
        for el in cart {
            userCart!.child(el.name).updateChildValues(["quantity": 0 ])
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "cartTOsendEmail" else {
            return
        }
        
        let vc = segue.destination as! SendEmailOrderViewController

        vc.orderDetails = sender as! [CartItem]
    }
    
    
    
    @IBAction func returnTOCart(sender: UIStoryboardSegue) {
        
    }*/
}
