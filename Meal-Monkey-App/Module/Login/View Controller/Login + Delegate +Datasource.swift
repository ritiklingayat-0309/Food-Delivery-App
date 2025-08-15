//
//  Login + Delegate +Datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import Foundation
import UIKit

extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtEmail:
            txtPassword.becomeFirstResponder()
        case txtPassword:
            btnLogin.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
