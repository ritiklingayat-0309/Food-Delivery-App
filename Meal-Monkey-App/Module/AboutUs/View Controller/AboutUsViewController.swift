//
//  AboutUsViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

/**
 A multi-purpose view controller that can display different types of information based on its `objPageType` property.
 This class is designed to handle the UI and logic for "About Us," "Notifications," "Inbox," and other informational screens.
 It dynamically configures the navigation bar and loads the appropriate data for each page type.
 */
class AboutUsViewController: UIViewController {
    
    /// The data source for the table view, populated based on the `objPageType`.
    var arrcurrentData: [AboutModel] = []
    
    /// The table view to display the data.
    @IBOutlet weak var tblView: UITableView!
    
    /// The type of page to be displayed, which determines the UI and data source.
    var objPageType: PageType = .About
    
    /// An enum that defines the different page types this view controller can handle.
    // Assuming this enum is defined elsewhere in your project
    enum PageType {
        case PaymentDetails
        case MyOrder
        case Notification
        case Inbox
        case About
        case Wishlist
        case Cart
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.showsVerticalScrollIndicator = false
        
        switch objPageType {
        case .PaymentDetails:
            print("Navigate to My payment screen")
            self.setLeftAlignedTitleWithBack("PaymentDetails", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            
        case .MyOrder:
            print("Navigate to My Orders screen")
            self.setLeftAlignedTitleWithBack("MyOrder", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            
        case .Notification:
            print("Navigate to Notification screen")
            self.setLeftAlignedTitleWithBack("Notification", target: self, action: #selector(backButtonTapped))
            arrcurrentData = AboutModel.addNotificationData()
            setCartButton(target: self, action: #selector(cartButtonTapped))
            
        case .Inbox:
            print("Navigate to Inbox screen")
            self.setLeftAlignedTitleWithBack("Inbox", target: self, action: #selector(backButtonTapped))
            arrcurrentData = AboutModel.addInboxData()
            setCartButton(target: self, action: #selector(cartButtonTapped))
            
        case .About:
            print("Navigate to About screen")
            self.setLeftAlignedTitleWithBack("About Us", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            arrcurrentData = AboutModel.addAboutData()
            
        case .Wishlist:
            print("this is wish list")
            self.setLeftAlignedTitleWithBack("About Us", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            
        case .Cart:
            self.setLeftAlignedTitleWithBack("Cart", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            print("this is cart page")
        }
        
        tblView.register(UINib(nibName: "AboutUsTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutUsTableViewCell")
        self.navigationItem.hidesBackButton = true
    }
    
    /**
     Handles the action for the back button in the navigation bar.
     This method pops the current view controller from the navigation stack.
     */
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    /**
     Handles the action for the cart button in the navigation bar.
     This method navigates the user to the `CartViewController`.
     */
    @objc func cartButtonTapped() {
        print("Cart tapped")
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            secondVC.pagetype = .Cart
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}
