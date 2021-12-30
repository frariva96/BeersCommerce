//
//  LoginViewController.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 29/12/21.
//

import UIKit
import Firebase

var userCart: DatabaseReference?
class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loginAction(_ sender: UIButton) {
        
        guard let username = usernameTxt.text, !username.isEmpty, let password = passwordTxt.text, !password.isEmpty else {
            return
        }
        
        Auth.auth().signIn(withEmail: username, password: password) { user, error in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            }else{
                self.usernameTxt.text = ""
                self.passwordTxt.text = ""
                self.performSegue(withIdentifier: "loginTOhome", sender: user?.user.uid)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "loginTOhome" else {
            return
        }
        
        let nav = segue.destination as! UITabBarController
        let vc = nav.viewControllers![0] as! UINavigationController
        let vc2 = vc.topViewController as! HomeViewController
        vc2.user = sender as? String
    }
    
    @IBAction func returnLogin(segue: UIStoryboardSegue) {
    }
}
