//
//  Send OTP Delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import Foundation
import UIKit
extension SendOTPViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }

        if string.count > 1 {
            return false
        }
        
        if string.count == 1 {
            textField.text = string
            
            switch textField {
            case txtOTP1:
                txtOTP2.becomeFirstResponder()
            case txtOTP2:
                txtOTP3.becomeFirstResponder()
            case txtOTP3:
                txtOTP4.becomeFirstResponder()
            case txtOTP4:
                txtOTP4.resignFirstResponder()
            default:
                break
            }
            return false
        } else if string.isEmpty { // Backspace pressed
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
            textField.text = ""
            
            return false
        }
        return true
    }
}
