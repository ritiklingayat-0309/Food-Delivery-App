//
//  Send OTP Delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import Foundation
import UIKit

/// Extension of `SendOTPViewController` to handle OTP text field behavior.
/// Implements `UITextFieldDelegate` to:
/// - Restrict input to digits only.
/// - Allow only one character per text field.
/// - Automatically move to the next/previous field when typing or deleting.
extension SendOTPViewController: UITextFieldDelegate {
    
    /// Controls user input in OTP text fields.
    ///
    /// - Parameters:
    ///   - textField: The active `UITextField` where input is being entered.
    ///   - range: The range of characters being replaced.
    ///   - string: The replacement string (new input).
    /// - Returns: A Boolean indicating whether the change should be made.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //Allow only numeric digits
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        
        // Prevent pasting multiple characters
        if string.count > 1 {
            return false
        }
        
        //If user typed a digit
        if string.count == 1 {
            textField.text = string
            
            // Automatically move to the next OTP field
            switch textField {
            case txtOTP1:
                txtOTP2.becomeFirstResponder()
            case txtOTP2:
                txtOTP3.becomeFirstResponder()
            case txtOTP3:
                txtOTP4.becomeFirstResponder()
            case txtOTP4:
                txtOTP4.resignFirstResponder() // last field, dismiss keyboard
            default:
                break
            }
            return false
        }
        // If user pressed backspace (deleting text)
        else if string.isEmpty {
            textField.text = ""
            
            // Move focus back to previous field
            switch textField {
            case txtOTP4:
                txtOTP3.becomeFirstResponder()
            case txtOTP3:
                txtOTP2.becomeFirstResponder()
            case txtOTP2:
                txtOTP1.becomeFirstResponder()
            default:
                break
            }
            return false
        }
        return true
    }
}
