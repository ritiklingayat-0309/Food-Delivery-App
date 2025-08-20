//
//  NewPasswordViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

/// `NewPasswordViewController`
/// Screen for setting a new password and confirming it.
/// Includes validation, password visibility toggle, and navigation
/// to the features screen once the password setup is complete.
class NewPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// Stack view wrapping confirm password field
    @IBOutlet weak var stackConfimPass: UIStackView!
    
    /// Stack view wrapping new password field
    @IBOutlet weak var stackNewPass: UIStackView!
    
    /// Eye button for toggling new password visibility
    @IBOutlet weak var btneyeNewPass: UIButton!
    
    /// Text field for entering the new password
    @IBOutlet weak var txtNewPassword: UITextField!
    
    /// Eye button for toggling confirm password visibility
    @IBOutlet weak var btnEyeConfirmPas: UIButton!
    
    /// Text field for confirming the new password
    @IBOutlet weak var txtCofirmPassword: UITextField!
    
    /// Next button to validate and proceed
    @IBOutlet weak var btnNext: UIButton!
    
    // MARK: - State
    
    /// Tracks visibility of new password field
    var isPasswordVisible: Bool = false
    
    /// Tracks visibility of confirm password field
    var isConfirmPasswordVisible: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the back button for this flow
        self.navigationItem.hidesBackButton = true
        
        // Apply UI styling using helper class
        EditStyle.setPadding(textFields: [txtNewPassword, txtCofirmPassword],
                             paddingWidth: 28)
        EditStyle.setborder(textfields: [btnNext])
        EditStyle.addStackBorder(stackViews: [stackConfimPass, stackNewPass])
    }
    
    // MARK: - Actions
    /// Toggle confirm password visibility (eye button)
    @IBAction func btnEyeConfirmPasAction(_ sender: Any) {
        isConfirmPasswordVisible.toggle()
        txtCofirmPassword.isSecureTextEntry = !isConfirmPasswordVisible
        
        let imageName = isConfirmPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    /// Toggle new password visibility (eye button)
    @IBAction func btnEyeNewPasswordAction(_ sender: Any) {
        isPasswordVisible.toggle()
        txtNewPassword.isSecureTextEntry = !isPasswordVisible
        
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    /// Validate inputs and navigate to Features screen
    @IBAction func btnNextAction(_ sender: Any) {
        let password = txtNewPassword.text ?? ""
        let confirmPassword = txtCofirmPassword.text ?? ""
        
        switch true {
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
            print("All validations passed. Continue registration.")
        }
        
        // Navigate to FeaturesViewController if validations are done
        let storyboard = UIStoryboard(name: "FeaturesStoryboard", bundle: nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier: "FeaturesViewController") as? FeaturesViewController {
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}
