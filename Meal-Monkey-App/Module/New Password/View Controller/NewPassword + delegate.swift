//
//  NewPassword + delegate.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 15/08/25.
//

import Foundation
import UIKit

extension NewPasswordViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtNewPassword:
            txtCofirmPassword.becomeFirstResponder()
        case txtCofirmPassword:
            txtCofirmPassword.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
