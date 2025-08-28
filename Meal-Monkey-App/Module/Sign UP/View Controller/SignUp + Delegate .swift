//
//  SignUp + Delegate .swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 15/08/25.
//

import Foundation
import UIKit

/// Extension of `SignUpViewController`
/// Handles text field navigation using the keyboard return key.
extension SignUpViewController : UITextFieldDelegate {
    
    /// Called when the return key is pressed on the keyboard.
    /// - Parameter textField: The active UITextField where return was pressed.
    /// - Returns: `true` to process the return key event.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
            /// If Name field is active → move to Email field
        case txtName:
            txtEmail.becomeFirstResponder()
            
            /// If Email field is active → move to Mobile No field
        case txtEmail:
            txtMobileNo.becomeFirstResponder()
            
            /// If Mobile No field is active → move to Address field
        case txtMobileNo:
            txtAddress.becomeFirstResponder()
            
            /// If Address field is active → move to Password field
        case txtAddress:
            txtPassword.becomeFirstResponder()
            
            /// If Password field is active → move to Confirm Password field
        case txtPassword:
            txtConfirmPassword.resignFirstResponder()
            
            /// Default case → resign first responder for any other text field
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
