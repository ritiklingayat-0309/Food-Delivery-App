//
//  SignUpViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 01/08/25.
//

import UIKit
import CoreData

/// Controller responsible for handling user sign-up flow,
/// including validation, saving data into Core Data,
/// and navigation to login screen if needed.
class SignUpViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var txtName: UITextField!                 /// Text field for entering user's full name
    @IBOutlet weak var txtMobileNo: UITextField!             /// Text field for entering mobile number
    @IBOutlet weak var txtEmail: UITextField!                /// Text field for entering email address
    @IBOutlet weak var txtAddress: UITextField!              /// Text field for entering address
    @IBOutlet weak var txtPassword: UITextField!             /// Text field for entering password
    @IBOutlet weak var txtConfirmPassword: UITextField!      /// Text field for confirming password
    @IBOutlet weak var btnSignUp: UIButton!                  /// Button to trigger sign-up process
    @IBOutlet weak var btnAlreadyHaveAccount: UIButton!      /// Button to navigate back to login screen
    @IBOutlet weak var stackPasswordeye: UIStackView!        /// Stack view containing password visibility toggle
    @IBOutlet weak var stackConfirmPaseye: UIStackView!      /// Stack view containing confirm-password visibility toggle
    
    // MARK: - Properties
    var isPasswordVisible : Bool = false                     /// Tracks visibility state of password field
    var isConfirmPasswordVisible : Bool = false              /// Tracks visibility state of confirm password field
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Hide default navigation back button
        self.navigationItem.hidesBackButton = true
        
        /// Apply padding and border styling to textfields & buttons
        EditStyle.setPadding(textFields: [txtName, txtMobileNo,txtEmail,txtAddress,txtPassword,txtConfirmPassword], paddingWidth: 28)
        EditStyle.setborder(textfields: [txtName, txtMobileNo, txtEmail,txtAddress,btnSignUp])
        EditStyle.addStackBorder(stackViews: [stackPasswordeye,stackConfirmPaseye])
    }
    
    // MARK: - Actions
    
    /// Toggle password visibility with eye icon button
    @IBAction func btnPasswordEyeAction(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    /// Toggle confirm password visibility with eye icon button
    @IBAction func btnConfirPassEyeAction(_ sender: Any) {
        isConfirmPasswordVisible = !isConfirmPasswordVisible
        txtConfirmPassword.isSecureTextEntry = !isConfirmPasswordVisible
        let imageName = isConfirmPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    /// Navigate back to login screen if user already has an account
    @IBAction func btnAlreadyAcountLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if ((storyboard.instantiateViewController(withIdentifier : "LoginViewController") as? LoginViewController) != nil){
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /// Handles sign-up process including:
    /// - Validation of inputs
    /// - Core Data saving of new user
    /// - Displaying alerts
    @IBAction func btnSignUpAction(_ sender: Any) {
        let name = txtName.text ?? ""
        let email = txtEmail.text ?? ""
        let mobile = txtMobileNo.text ?? ""
        let address = txtAddress.text ?? ""
        let password = txtPassword.text ?? ""
        let confirmPassword = txtConfirmPassword.text ?? ""
        
        /// Validate user inputs using switch-case style
        switch true {
        case name.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter name",
                                        viewController: self)
            
        case email.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter email",
                                        viewController: self)
            
        case !email.isValidEmail:
            UIAlertController.showAlert(title: "Invalid Email",
                                        message: "Please enter a valid email address.",
                                        viewController: self)
            
        case mobile.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter mobile number",
                                        viewController: self)
            
        case mobile.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil:
            UIAlertController.showAlert(title: "Error",
                                        message: "Mobile number must contain only digits",
                                        viewController: self)
            
        case mobile.count != 10:
            UIAlertController.showAlert(title: "Error",
                                        message: "Mobile number must be exactly 10 digits.",
                                        viewController: self)
            
        case address.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter address",
                                        viewController: self)
            
        case password.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter password",
                                        viewController: self)
            
        case !password.isValidPassword:
            UIAlertController.showAlert(title: "Invalid Password",
                                        message: "Please enter a valid password.",
                                        viewController: self)
            
        case confirmPassword.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter confirm password",
                                        viewController: self)
            
        case password != confirmPassword:
            UIAlertController.showAlert(title: "Error",
                                        message: "Confirm password does not match",
                                        viewController: self)
            
        default:
            /// Save user in Core Data
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            guard let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext) else { return }
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(name, forKey: "name")
            user.setValue(email, forKey: "email")
            user.setValue(mobile, forKey: "mobileNo")
            user.setValue(address, forKey: "address")
            user.setValue(password, forKey: "password")
            user.setValue(UUID(), forKey: "userID")
            
            do {
                /// Try saving user to Core Data
                try managedContext.save()
                print("✅ User saved successfully!")
                
                /// Show success alert and pop back to login
                UIAlertController.showAlert(title: "Success",
                                            message: "Registration successful! You can now log in.",
                                            viewController: self){
                    self.navigationController?.popViewController(animated: true)
                }
            } catch let error as NSError {
                /// Handle error in saving user
                print("❌ Could not save user. \(error), \(error.userInfo)")
                
                UIAlertController.showAlert(title: "Error",
                                            message: "Registration failed. Please try again.",
                                            viewController: self)
            }
        }
    }
}
