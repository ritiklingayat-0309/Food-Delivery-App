//
//  Cart+badge.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 20/08/25.
//

import UIKit

extension UIViewController {
    
    // MARK: - Setup Cart Button
    
    /// Sets up a cart button with badge and adds it to the right side of the navigation bar.
    /// - Parameters:
    ///   - target: The target object that receives the action message.
    ///   - action: The selector identifying the action method to be called.
    func setCartButton(target: Any?, action: Selector) {
        let totalQuantity = CartManager.shared.getCartQuantity()
        
        // Create cart button
        let btnCart = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btnCart.setBackgroundImage(UIImage(systemName: "cart.fill"), for: .normal)
        btnCart.tintColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)
        btnCart.addTarget(target, action: action, for: .touchUpInside)
        
        // Create badge label for showing cart quantity
        let badgeLabel = UILabel()
        badgeLabel.tag = 1001
        badgeLabel.text = "\(totalQuantity)"
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = .loginBackground
        badgeLabel.font = .systemFont(ofSize: 12)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.clipsToBounds = true
        badgeLabel.frame = CGRect(x: 18, y: -5, width: 20, height: 20)
        badgeLabel.isHidden = totalQuantity == 0
        btnCart.addSubview(badgeLabel)
        
        // Add cart button to navigation bar
        let cartBarButton = UIBarButtonItem(customView: btnCart)
        navigationItem.rightBarButtonItems = (navigationItem.rightBarButtonItems ?? []) + [cartBarButton]
        
        // 🔔 Listen for cart update notifications
        NotificationCenter.default.addObserver(
            forName: .cartUpdated,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.updateCartBadge()
        }
    }
    
    // MARK: - Update Badge
    /// Updates the cart badge with the latest quantity.
    /// Hides the badge if cart is empty.
    func updateCartBadge() {
        let totalQuantity = CartManager.shared.getCartQuantity()
        if let btnCart = navigationItem.rightBarButtonItems?.last?.customView as? UIButton,
           let lblQuantity = btnCart.viewWithTag(1001) as? UILabel {
            lblQuantity.text = "\(totalQuantity)"
            lblQuantity.isHidden = totalQuantity == 0
        }
    }
}
