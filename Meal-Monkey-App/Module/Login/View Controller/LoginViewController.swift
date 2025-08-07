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
    @IBOutlet weak var btnEye: UIButton!
    var isPasswordVisible : Bool = false
    
    @IBOutlet weak var stackViewPass: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        viewStyle(textfield: [txtEmail,btnLogin, btnForget, btnLoginWithFaceBook, btnLoginWithGoogle])
        setPadding(textfield: [txtEmail, txtPassword])
        Style.addStackBorder(stackViews : [stackViewPass])
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
    
    @IBAction func btnEyeAction(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        //        let email = txtEmail.text ?? ""
        //        let pass = txtPassword.text ?? ""
        //
        //        guard !email.isEmpty else {
        //            UIAlertController.showAlert(title: "Error", message: "Please Enter Email", viewController: self)
        //            return
        //        }
        //
        //        guard email.isValidEmail else {
        //            UIAlertController.showAlert(title: "Invalid Email", message: "Please enter a valid email address.", viewController: self)
        //            return
        //        }
        //
        //        guard !pass.isEmpty else {
        //            UIAlertController.showAlert(title: "Error", message: "Please Enter password", viewController: self)
        //            return
        //        }
        //
        //        guard pass.isValidPassword else {
        //            UIAlertController.showAlert(
        //                title: "Invalid Password",
        //                message: """
        //                        Please Password must be at least 8 characters long,
        //                        contain at least 1 uppercase letter,
        //                        1 lowercase letter, 1 number, and 1 special character.
        //                        """,
        //                viewController: self
        //            )
        //            return
        //        }
        showMainTabBar()
    }
    
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? UITabBarController {
            // Set as rootViewController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    @IBAction func btnForgetAction(_ sender: Any) {
        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "ResetPasswordViewController") as? ResetPasswordViewController{
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
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
