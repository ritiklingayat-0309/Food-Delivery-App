//
//  LoginViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 31/07/25.
//

import UIKit
import CoreData

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
        EditStyle.addStackBorder(stackViews : [stackViewPass])
        EditStyle.setPadding(textFields: [txtEmail,txtPassword], paddingWidth: 28)
        EditStyle.setborder(textfields: [txtEmail,btnLogin, btnForget, btnLoginWithFaceBook, btnLoginWithGoogle])
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
        let email = txtEmail.text ?? ""
        let pass = txtPassword.text ?? ""
        
        switch true {
        case email.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please Enter Email",
                                        viewController: self)
            
        case !email.isValidEmail:
            UIAlertController.showAlert(title: "Invalid Email",
                                        message: "Please enter a valid email address.",
                                        viewController: self)
            
        case pass.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please Enter password",
                                        viewController: self)
            
        case !pass.isValidPassword:
            UIAlertController.showAlert(title: "Invalid Password",
                                        message: """
                                            Please Password must be at least 8 characters long,
                                            contain at least 1 uppercase letter,
                                            1 lowercase letter, 1 number, and 1 special character.
                                            """,
                                        viewController: self)
            
        default:
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
            let predicate = NSPredicate(format: "email == %@ AND password == %@", email, pass)
            fetchRequest.predicate = predicate
            
            do {
                let users = try managedContext.fetch(fetchRequest)
                
                if let loggedInUser = users.first {
                    print("Login successful for user: \(loggedInUser.value(forKey: "name") ?? "")")
                    if let userID = loggedInUser.value(forKey: "userID") as? UUID {
                        UserDefaults.standard.set(userID.uuidString, forKey: "loggedInUserID")
                    }
                    
                    self.showMainTabBar()
                    
                } else {
                    UIAlertController.showAlert(title: "Error",
                                                message: "User not found. Please check your credentials or sign up.",
                                                viewController: self)
                }
            } catch {
                print("Failed to fetch user: \(error.localizedDescription)")
                UIAlertController.showAlert(title: "Error",
                                            message: "Login failed. Please try again later.",
                                            viewController: self)
            }
        }
    }
    
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? UITabBarController {
            tabBarController.selectedIndex = 2
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    @IBAction func btnForgetAction(_ sender: Any) {
        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "ResetPasswordViewController") as? ResetPasswordViewController {
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
    
    @IBAction func btnLoginWithFacebookAction(_ sender: Any) {}
    @IBAction func btnLoginWithGoogleAction(_ sender: Any) {}
    
    @IBAction func btnSignInAction(_ sender: Any) {
        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}
