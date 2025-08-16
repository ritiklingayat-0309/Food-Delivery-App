//
//  AboutUsViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

class AboutUsViewController: UIViewController {
    var currentData: [AboutModel] = []
    @IBOutlet weak var tblView: UITableView!
    var objPageType: PageType = .About
    
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
            currentData = AboutModel.addNotificationData()
            setCartButton(target: self, action: #selector(cartButtonTapped))
            
        case .Inbox:
            print("Navigate to Inbox screen")
            self.setLeftAlignedTitleWithBack("Inbox", target: self, action: #selector(backButtonTapped))
            currentData = AboutModel.addInboxData()
            setCartButton(target: self, action: #selector(cartButtonTapped))
            
        case .About:
            print("Navigate to About screen")
            self.setLeftAlignedTitleWithBack("About Us", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            currentData = AboutModel.addAboutData()
            
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
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cartButtonTapped() {
        print("Cart tapped")
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            secondVC.pagetype = .Cart
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}

