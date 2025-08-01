//
//  AlertHelper.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 01/08/25.
//


import Foundation
import UIKit
import Foundation
import UIKit

//common alert
extension UIAlertController {
    class func showAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
            
        }))
        viewController.present(alert, animated: true)
    }
}

//For Padding
extension UITextField {
    func setPadding(left: CGFloat = 0, right: CGFloat = 0) {
        if left > 0 {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        if right > 0 {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}

//for border and bordercolor
extension UIView {
    func design() {
        self.layer.cornerRadius = 28
        self.clipsToBounds = true
    }
}

//for email and password validation
extension String {
    var isValidPassword: Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$"#
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }
}




