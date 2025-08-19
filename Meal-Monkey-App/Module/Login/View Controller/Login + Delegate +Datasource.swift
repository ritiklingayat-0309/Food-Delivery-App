//
//  Login + Delegate +Datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import Foundation
import UIKit

/// Extension of `LoginViewController` to handle `UITextFieldDelegate` methods
extension LoginViewController : UITextFieldDelegate {
    
    /// Called when the return key is pressed on the keyboard
    /// - Parameter textField: The text field whose return button was pressed
    /// - Returns: Boolean indicating whether the text field should process the return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtEmail:
            // Move focus to password field
            txtPassword.becomeFirstResponder()
        case txtPassword:
            // Dismiss keyboard for login button (not a text field)
            btnLogin.resignFirstResponder()
        default:
            // Dismiss keyboard for any other text field
            textField.resignFirstResponder()
        }
        return true
    }
}
