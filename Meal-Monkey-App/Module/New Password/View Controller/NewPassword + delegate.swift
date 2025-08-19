//
//  NewPassword + delegate.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 15/08/25.
//

import Foundation
import UIKit

/// Extension to handle `UITextFieldDelegate` methods for `NewPasswordViewController`.
///
/// This extension manages the keyboard return key navigation between
/// password text fields (new password and confirm password).
extension NewPasswordViewController: UITextFieldDelegate {
    
    /// Called when the return key is pressed on the keyboard.
    ///
    /// - Parameter textField: The text field where the return key was pressed.
    /// - Returns: A boolean value indicating whether the text field should process the return key press.
    ///
    /// Behavior:
    /// - If user is typing in `txtNewPassword`, the focus shifts to `txtCofirmPassword`.
    /// - If user is in `txtCofirmPassword`, the keyboard will be dismissed.
    /// - For any other text field, the keyboard will also be dismissed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtNewPassword:
            // Move focus to confirm password field
            txtCofirmPassword.becomeFirstResponder()
            
        case txtCofirmPassword:
            // Dismiss keyboard when confirm password field is done
            txtCofirmPassword.resignFirstResponder()
            
        default:
            // Default case: dismiss keyboard
            textField.resignFirstResponder()
        }
        return true
    }
}
