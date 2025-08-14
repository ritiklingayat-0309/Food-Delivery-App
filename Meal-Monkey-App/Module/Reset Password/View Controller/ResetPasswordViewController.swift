//
//  ResetPasswordViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 01/08/25.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        EditStyle.setPadding(textFields: [txtEmail], paddingWidth: 28)
        EditStyle.setborder(textfields: [txtEmail,btnSend])
    }
    
    @IBAction func btnSendAction(_ sender: Any) {
        let email = txtEmail.text ?? ""
        
        switch true {
        case email.isEmpty:
            UIAlertController.showAlert(
                title: "Error",
                message: "Please enter your email.",
                viewController: self
            )
            
        case !email.isValidEmail:
            UIAlertController.showAlert(
                title: "Invalid Email",
                message: "Please enter a valid email address.",
                viewController: self
            )
            
        default:
            print("Valid email entered.")
        }
        
        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "SendOTPViewController") as? SendOTPViewController{
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}
