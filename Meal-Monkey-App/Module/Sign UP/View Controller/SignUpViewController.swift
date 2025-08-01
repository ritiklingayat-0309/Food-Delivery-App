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
        txtName.design()
        txtMobileNo.design()
        txtEmail.design()
        txtAddress.design()
        txtPassword.design()
        txtConfirmPassword.design()
        btnSignUp.design()
        
        txtName.setPadding(left: 20, right: 20)
        txtMobileNo.setPadding(left: 20, right: 20)
        txtEmail.setPadding(left: 20, right: 20)
        txtPassword.setPadding(left: 20, right: 20)
        txtConfirmPassword.setPadding(left: 20, right: 20)
        

        self.navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func btnAlreadyAcountLogin(_ sender: Any) {
        
        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if ((storyboard.instantiateViewController(withIdentifier : "LoginViewController") as? LoginViewController) != nil){
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
}
