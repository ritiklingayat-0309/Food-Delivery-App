//
//  AlertHelper.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 01/08/25.
//

import Foundation
import UIKit

/**
 An extension to `UIAlertController` to provide a common, easy-to-use method for displaying alerts.
 This simplifies the process of presenting a basic alert with a single "OK" button and an optional completion handler.
 */
extension UIAlertController {
    
    /**
     Displays a standard alert with a title, message, and a single "OK" button.
     - Parameters:
     - title: The title of the alert.
     - message: The message to be displayed in the alert.
     - viewController: The view controller that will present the alert.
     - completion: An optional closure to be executed when the "OK" button is tapped.
     */
    static func showAlert(title: String,
                          message: String,
                          viewController: UIViewController,
                          completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}

/**
 An extension to `UIView` to provide a common method for applying visual styling.
 */
extension UIView {
    
    /**
     Applies a corner radius, border width, and border color to a view.
     
     - Parameters:
     - cornerRadius: The radius of the view's corners.
     - borderWidth: The width of the view's border.
     - borderColor: The color of the view's border.
     */
    func viewStyle(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}

/**
 An extension to `UITextField` to provide a common method for adding left and right padding.
 */
extension UITextField {
    /**
     Adds padding to the left and/or right of the text in a text field.
     
     - Parameters:
     - left: The amount of padding to add to the left side.
     - right: The amount of padding to add to the right side.
     */
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

/**
 A helper class for applying common styling to UI elements.
 */
class Style {
    /**
     Applies a border and corner radius to a list of UIViews.
     
     - Parameter stackViews: An array of `UIView` objects to be styled.
     */
    class func addStackBorder(stackViews: [UIView]) {
        for stackView in stackViews {
            stackView.layer.cornerRadius = 28
            stackView.layer.borderColor = UIColor.lightGray.cgColor
            stackView.clipsToBounds = true
        }
    }
}
