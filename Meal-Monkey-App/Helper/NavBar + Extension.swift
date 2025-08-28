//
//  NavBar + Extension.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import Foundation
import UIKit

/**
 An extension to `UIViewController` to provide common, reusable methods for configuring the navigation bar.
 This simplifies the process of setting a left-aligned title with a back button, a title without a back button, and a cart button on the right.
 */
extension UIViewController {
    /**
     Sets a left-aligned title on the navigation bar with a custom back button.
     - Parameters:
     - title: The string to be displayed as the title.
     - font: The font of the title. Defaults to system font size 29.
     - textColor: The color of the title and back button. Defaults to a custom color named "NavigationColor" or black.
     - target: The object that receives the action message.
     - action: The selector to be called when the back button is tapped.
     */
    func setLeftAlignedTitleWithBack(_ title: String,
                                     font: UIFont = .systemFont(ofSize: 29),
                                     textColor: UIColor = UIColor(named: "NavigationColor") ?? .black,
                                     target: Any?,
                                     action: Selector) {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.setTitle("  \(title)", for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = font
        button.tintColor = textColor
        button.addTarget(target, action: action, for: .touchUpInside)
        button.sizeToFit()
        let leftItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    /**
     Sets a left-aligned title on the navigation bar without a back button.
     
     - Parameters:
     - title: The string to be displayed as the title.
     - font: The font of the title. Defaults to system font size 29.
     - textColor: The color of the title. Defaults to a custom color named "NavigationColor" or black.
     */
    func setLeftAlignedTitle(_ title: String, font: UIFont = .systemFont(ofSize: 29), textColor: UIColor = UIColor(named: "NavigationColor") ?? .black) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }
}
