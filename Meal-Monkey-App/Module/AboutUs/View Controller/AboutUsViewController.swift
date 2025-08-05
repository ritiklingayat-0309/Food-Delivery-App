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
            
        case .MyOrder:
            print("Navigate to My Orders screen")
            
        case .Notification:
            print("Navigate to Notification screen")
            self.setLeftAlignedTitleWithBack("Notification", target: self, action: #selector(backButtonTapped))
            currentData = AboutModel.addNotificationData()
            
        case .Inbox:
            print("Navigate to Inbox screen")
            self.setLeftAlignedTitleWithBack("Inbox", target: self, action: #selector(backButtonTapped))
            currentData = AboutModel.addInboxData()
            
        case .About:
            print("Navigate to About screen")
            self.setLeftAlignedTitleWithBack("About Us", target: self, action: #selector(backButtonTapped))
            currentData = AboutModel.addAboutData()
        }
        tblView.register(UINib(nibName: "AboutUsTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutUsTableViewCell")
        self.navigationItem.hidesBackButton = true
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

