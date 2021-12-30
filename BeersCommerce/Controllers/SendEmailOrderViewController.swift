//
//  SendEmailOrderViewController.swift
//  BeersCommerce
//
//  Created by Francesco Riva on 30/12/21.
//

import UIKit
import MessageUI
import SafariServices
class SendEmailOrderViewController: UIViewController, MFMailComposeViewControllerDelegate{
    
    var orderDetails: [CartItem] = []
    
    var textMail: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        

        var result: String = ""
        var totBeers = 0
        
        for el in orderDetails {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint)\(el.name) x \(el.quantity)\n"
            result = result + formattedString
            totBeers += el.quantity
        }
        
        textMail = result + "\n Total pieces: \(totBeers)"
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
    
    
    /*@IBAction func sendEmailAction(_ sender: UIButton) {
        sendEmail(recipient: emailUser!, text: textMail!)
    }*/
    
}
