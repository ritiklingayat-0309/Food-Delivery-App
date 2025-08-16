//
//  NavBar + Extension.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import Foundation
import UIKit

extension UIViewController {
    func setLeftAlignedTitleWithBack(_ title: String,font: UIFont = .systemFont(ofSize: 29),
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
