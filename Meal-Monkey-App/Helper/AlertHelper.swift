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

extension UIView {
    
    func viewStyle(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
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

//for email and password validation
extension String {
    var isValidPassword: Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: trimmed)
    }
}

extension UIViewController {
    
    func setLeftAlignedTitleWithBack(_ title: String, font: UIFont = .systemFont(ofSize: 29), textColor: UIColor = UIColor(named: "NavigationColor") ?? .black, target: Any?, action: Selector) {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = textColor
        backButton.addTarget(target, action: action, for: .touchUpInside)
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()
        let stackView = UIStackView(arrangedSubviews: [backButton, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        let leftItem = UIBarButtonItem(customView: stackView)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func setLeftAlignedTitle(_ title: String, font: UIFont = .systemFont(ofSize: 29), textColor: UIColor = UIColor(named: "NavigationColor") ?? .black) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func setCartButton(target: Any?, action: Selector, tintColor: UIColor = UIColor(named: "NavigationColor") ?? .black) {
        let cartImage = UIImage(systemName: "cart.fill")?.withRenderingMode(.alwaysTemplate)
        let cartButton = UIBarButtonItem(image: cartImage, style: .plain, target: target, action: action)
        cartButton.tintColor = tintColor
        self.navigationItem.rightBarButtonItem = cartButton
    }
}







