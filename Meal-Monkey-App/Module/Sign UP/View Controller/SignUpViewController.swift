//
//  SignUpViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 01/08/25.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnAlreadyHaveAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        viewStyle(textfield: [txtName, txtMobileNo, txtEmail,txtAddress,txtConfirmPassword,btnSignUp,txtPassword])
        setPadding(textfield: [txtName, txtMobileNo,txtEmail,txtAddress,txtPassword,txtConfirmPassword])
    }
    
    func viewStyle(textfield: [UIView]){
        for item in textfield {
            item.viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray)
        }
    }
    
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @IBAction func btnAlreadyAcountLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if ((storyboard.instantiateViewController(withIdentifier : "LoginViewController") as? LoginViewController) != nil){
            self.navigationController?.popViewController(animated: true)
        }
    }
}
