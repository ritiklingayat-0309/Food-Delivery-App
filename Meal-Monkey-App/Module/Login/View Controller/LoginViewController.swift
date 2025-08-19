//
//  LoginViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 31/07/25.
//

import UIKit
import CoreData

/// `LoginViewController` handles user login functionality including email/password login,
/// password visibility toggle, login with Facebook/Google, and navigation to SignUp or ResetPassword screens.
class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    /// Login button
    @IBOutlet weak var btnLogin: UIButton!
    
    /// Forget password button
    @IBOutlet weak var btnForget: UIButton!
    
    /// Login with Facebook button
    @IBOutlet weak var btnLoginWithFaceBook: UIButton!
    
    /// Login with Google button
    @IBOutlet weak var btnLoginWithGoogle: UIButton!
    
    /// Sign up button
    @IBOutlet weak var btnSignIn: UIButton!
    
    /// Email text field
    @IBOutlet weak var txtEmail: UITextField!
    
    /// Password text field
    @IBOutlet weak var txtPassword: UITextField!
    
    /// Password visibility toggle button
    @IBOutlet weak var btnEye: UIButton!
    
    /// Flag to track password visibility state
    var isPasswordVisible : Bool = false
    
    /// Stack view containing password field and eye button
    @IBOutlet weak var stackViewPass: UIStackView!
    
    // MARK: - View Lifecycle
    
    /// Called after the view has been loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        // Apply styles to UI elements
        EditStyle.addStackBorder(stackViews : [stackViewPass])
        EditStyle.setPadding(textFields: [txtEmail,txtPassword], paddingWidth: 28)
        EditStyle.setborder(textfields: [txtEmail,btnLogin, btnForget, btnLoginWithFaceBook, btnLoginWithGoogle])
        
        // Hide tab bar on login screen
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - IBActions
    
    /// Toggle password visibility
    /// - Parameter sender: UIButton that triggered the action
    @IBAction func btnEyeAction(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    /// Handle login button action
    /// - Parameter sender: UIButton that triggered the action
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
            // Perform Core Data fetch for login
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
                    KeychainHelper.save(key: "LoginStatus", value: "true")
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
    
    // MARK: - Private Methods
    
    /// Show the main tab bar controller after successful login
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
    
    /// Navigate to ResetPassword screen
    /// - Parameter sender: UIButton that triggered the action
    @IBAction func btnForgetAction(_ sender: Any) {
        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "ResetPasswordViewController") as? ResetPasswordViewController {
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
    
    /// Placeholder for login with Facebook action
    /// - Parameter sender: UIButton that triggered the action
    @IBAction func btnLoginWithFacebookAction(_ sender: Any) {
    }
    
    /// Placeholder for login with Google action
    /// - Parameter sender: UIButton that triggered the action
    @IBAction func btnLoginWithGoogleAction(_ sender: Any) {
    }
    
    /// Navigate to SignUp screen
    /// - Parameter sender: UIButton that triggered the action
    @IBAction func btnSignInAction(_ sender: Any) {
        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}
