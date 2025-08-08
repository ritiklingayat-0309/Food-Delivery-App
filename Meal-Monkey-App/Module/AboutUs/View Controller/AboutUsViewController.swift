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
        
        switch objPageType {
        case .PaymentDetails:
            print("Navigate to My payment screen")
            self.setLeftAlignedTitleWithBack("PaymentDetails", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
//            let storyboard = UIStoryboard(name:"MoreStoryboard", bundle : nil)
//            if let secondVc = storyboard.instantiateViewController(withIdentifier : "PaymentDetailsViewController") as? PaymentDetailsViewController{
//                self.navigationController?.pushViewController(secondVc, animated: true)
//            }
            
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
        }
        tblView.register(UINib(nibName: "AboutUsTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutUsTableViewCell")
        self.navigationItem.hidesBackButton = true
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cartButtonTapped() {
        // Handle cart button tap
        print("Cart tapped")
    }
}

