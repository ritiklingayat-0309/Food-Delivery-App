//
//  ResetPasswordViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 01/08/25.
//

import UIKit

/// `ResetPasswordViewController`
///
/// This screen allows the user to reset their password by entering an email.
/// Steps:
/// - User enters their registered email.
/// - Input is validated (empty or invalid email check).
/// - On success, user navigates to the OTP verification screen (`SendOTPViewController`).
class ResetPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    /// Text field for entering email address
    @IBOutlet weak var txtEmail: UITextField!
    /// Button to trigger reset password action
    @IBOutlet weak var btnSend: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the navigation back button (to avoid going back unintentionally)
        self.navigationItem.hidesBackButton = true
        // Apply padding inside email text field
        EditStyle.setPadding(textFields: [txtEmail], paddingWidth: 28)
        // Apply border styling to email text field and send button
        EditStyle.setborder(textfields: [txtEmail, btnSend])
    }
    
    
    // MARK: - Actions
    
    /// Action triggered when the "Send" button is pressed.
    /// Validates the email and, if valid, navigates to OTP screen.
    @IBAction func btnSendAction(_ sender: Any) {
        let email = txtEmail.text ?? ""
        
        // Validate email input
        switch true {
        case email.isEmpty:
            // Case 1: Empty input
            UIAlertController.showAlert(
                title: "Error",
                message: "Please enter your email.",
                viewController: self
            )
            
        case !email.isValidEmail:
            // Case 2: Invalid email format
            UIAlertController.showAlert(
                title: "Invalid Email",
                message: "Please enter a valid email address.",
                viewController: self
            )
            
        default:
            // Case 3: Valid email
            print("Valid email entered.")
        }
        
        // Navigate to OTP verification screen
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier: "SendOTPViewController") as? SendOTPViewController {
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}
