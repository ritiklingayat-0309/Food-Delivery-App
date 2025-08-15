//
//  SignUp + Delegate .swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 15/08/25.
//

import Foundation
import UIKit

extension SignUpViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtName:
            txtEmail.becomeFirstResponder()
        case txtEmail:
            txtMobileNo.becomeFirstResponder()
        case txtMobileNo:
            txtAddress.becomeFirstResponder()
        case txtAddress:
            txtPassword.becomeFirstResponder()
        case txtPassword:
            txtConfirmPassword.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
