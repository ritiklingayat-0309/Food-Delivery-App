//
//  LoginViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 31/07/25.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForget: UIButton!
    @IBOutlet weak var btnLoginWithFaceBook: UIButton!
    @IBOutlet weak var btnLoginWithGoogle: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        btnLogin.design()
        btnLoginWithGoogle.design()
        btnLoginWithFaceBook.design()
        txtEmail.design()
        txtPassword.design()
        
        txtEmail.setPadding(left: 20, right: 20)
        txtPassword.setPadding(left: 20,right: 20)

    }
    
    
    @IBAction func btnLoginAction(_ sender: Any) {
    }
    
    
    @IBAction func btnForgetAction(_ sender: Any) {
    }
    
   
    @IBAction func btnLoginWithFacebookAction(_ sender: Any) {
    }
    
    
    @IBAction func btnLoginWithGoogleAction(_ sender: Any) {
    }
    
    @IBAction func btnSignInAction(_ sender: Any) {
        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "SignUpViewController") as? SignUpViewController{
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
    
    

}
