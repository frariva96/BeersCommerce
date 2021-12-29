//
//  SignInViewController.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 29/12/21.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                self.performSegue(withIdentifier: "signinTOhome", sender: nil)
            }
        }
        
        
    }
    
}
