//
//  Padding + Border Helper.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import Foundation
import UIKit

class EditStyle {
    class func setborder(textfields: [UIView]) {
        for textField in textfields {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = 28
            textField.clipsToBounds = false
        }
    }
    
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
    
    class func addStackBorder(stackViews: [UIView]) {
        for stackView in stackViews {
            stackView.layer.cornerRadius = 28
            stackView.layer.borderColor = UIColor.lightGray.cgColor
            stackView.clipsToBounds = true
        }
    }
}
