//
//  SignInViewController.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 29/12/21.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    var beerlistFirebase: DatabaseReference?
    
    var beerViewModel: BeersViewModel!
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBeersData()
        
    }
    
    func loadBeersData () {
        beerViewModel = BeersViewModel()
    }
    
    
    
    @IBAction func signInAction(_ sender: UIButton) {
        
        
        guard let email = usernameTxt.text, !email.isEmpty, let password = passwordTxt.text, !password.isEmpty else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                //self.performSegue(withIdentifier: "signinTOhome", sender: nil)
                
                self.beerlistFirebase = Database.database().reference().child("cartUser").child((user?.user.uid)!)
                
                for beer in beersList {
                    self.beerlistFirebase!.child(beer.name).updateChildValues(
                        ["id": beer.id, "name": beer.name, "imageUrl": beer.imageUrl, "description": beer.description, "abv": beer.abv, "ibu": beer.ibu, "firstBrewed": beer.firstBrewed, "foodPairing": beer.foodPairing, "brewersTips": beer.brewersTips, "quantity": 0])
                }
                
                
            }
            
        }
    }
}
