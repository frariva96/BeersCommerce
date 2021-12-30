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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func sendEmail(recipient: String, text: String){
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipient])
            mail.setMessageBody(text, isHTML: false)
            
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
    
    
    @IBAction func sendEmailAction(_ sender: UIButton) {
        
        sendEmail(recipient: "friva.73@gmail.com", text: "CIAO")
    }
    
}
