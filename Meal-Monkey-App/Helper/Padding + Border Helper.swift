//
//  Padding + Border Helper.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import Foundation
import UIKit

/**
 A utility class that provides common styling functions for UI elements.
 
 This class simplifies the process of applying consistent visual styles such as borders,
 corner radius, and padding to text fields and other views.
 */
class EditStyle {
    
    /**
     Applies a border, corner radius, and clips to bounds for a list of UIViews.
     
     This method is useful for applying a consistent visual style to multiple
     text fields or other view containers.
     
     - Parameter textfields: An array of `UIView` objects to be styled.
     */
    class func setborder(textfields: [UIView]) {
        for textField in textfields {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = 28
            textField.clipsToBounds = false
        }
    }
    
    /**
     Adds a left padding view to a list of `UITextField` objects.
     
     This method iterates through the provided views and, if the view is a `UITextField`,
     it adds a transparent view to the left side to create visual padding.
     
     - Parameters:
        - textFields: An array of `UIView` objects, some of which may be `UITextField`s.
        - paddingWidth: The desired width of the padding on the left side.
     */
    class func setPadding(textFields: [UIView], paddingWidth: CGFloat) {
        for view in textFields {
            if let textField = view as? UITextField {
                let paddingView = UIView(
                    frame: CGRect(
                        x: 0,
                        y: 0,
                        width: paddingWidth,
                        height: textField.frame.height
                    )
                )
                textField.leftView = paddingView
                textField.leftViewMode = .always
            }
        }
    }
    
    /**
     Applies a border, corner radius, and clips to bounds for a list of stack views.
     
     This method is useful for styling `UIStackView` containers with a consistent border.
     
     - Parameter stackViews: An array of `UIView` objects, typically `UIStackView`s.
     */
    class func addStackBorder(stackViews: [UIView]) {
        for stackView in stackViews {
            stackView.layer.cornerRadius = 28
            stackView.layer.borderColor = UIColor.lightGray.cgColor
            stackView.clipsToBounds = true
        }
    }
}
