//
//  CheckOutViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import UIKit

class CheckOutViewController: UIViewController,MapViewControllerDelegate {
    
    var arrCards : [String] = ["Card -1 ", "card -2 ", "card -3 "]
    var subtotal: Double?
    var deliveryCost: Double?
    var total: Double?
    //thank you Page
    @IBOutlet weak var viewThanku: UIView!
    @IBOutlet weak var btnCancelX: UIButton!
    @IBOutlet weak var btnTrackMyOrder: UIButton!
    @IBOutlet weak var btnBackToHome: UIButton!
    @IBOutlet weak var viewTop: UIView!
    //card view
    @IBOutlet weak var txtCardNo: UITextField!
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var viewScroll: UIView!
    @IBOutlet weak var viewAddCard: UIView!
    @IBOutlet weak var txtExpMonth: UITextField!
    @IBOutlet weak var txtExpYear: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var btnAddCardCardView: UIButton!
    //checkout View
    @IBOutlet weak var lblChangeAddress: UILabel!
    @IBOutlet weak var btnChangeAddress: UIButton!
    @IBOutlet weak var btnSendOrder: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDeliveryCost: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitleWithBack("CheckOut", target: self, action: #selector(backButtonTapped))
        EditStyle.setborder(textfields: [btnSendOrder,btnTrackMyOrder,btnAddCardCardView,txtExpMonth,txtExpYear,txtSecurityCode,txtFirstName,txtLastName,txtCardNo])
        EditStyle.setPadding(textFields: [txtSecurityCode,txtExpYear,txtExpMonth,txtFirstName,txtLastName,txtCardNo], paddingWidth: 28)
        tblView.register(UINib(nibName: "CashOnDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "CashOnDeliveryTableViewCell")
        tblView.register(UINib(nibName: "GmailTableViewCell", bundle: nil), forCellReuseIdentifier: "GmailTableViewCell")
        tblView.register(UINib(nibName: "VisaTableViewCell", bundle: nil), forCellReuseIdentifier: "VisaTableViewCell")
        viewThanku.isHidden = true
        viewTop.isHidden = true
        viewAddCard.isHidden = true
        viewAddCard.layer.cornerRadius = 20
        viewAddCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewAddCard.layer.shadowColor = UIColor.black.cgColor
        viewAddCard.layer.shadowOpacity = 0.2
        viewAddCard.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewAddCard.layer.shadowRadius = 10
        viewScroll.layer.cornerRadius = 20
        viewScroll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewScroll.layer.shadowColor = UIColor.black.cgColor
        viewScroll.layer.shadowOpacity = 0.2
        viewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewScroll.layer.shadowRadius = 10
 
        if let subtotal = subtotal {
            lblSubTotal.text = "$\(String(format: "%.2f", subtotal))"
        }
        if let deliveryCost = deliveryCost {
            lblDeliveryCost.text = "$\(String(format: "%.2f", deliveryCost))"
        }
        if let total = total {
            lblTotal.text = "$\(String(format: "%.2f", total))"
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func didSelectAddress(_ address: String) {
        lblChangeAddress.text = address
    }
    
    @IBAction func btnSendOrderAction(_ sender: Any) {
        viewAddCard.isHidden = true
        viewTop.isHidden = false
        viewThanku.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewAddCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    @IBAction func btnTrackMyOrderAction(_ sender: Any) {
    }
    
    @IBAction func btnBackToHomeAction(_ sender: Any) {
    }
    
    @IBAction func btnChangeAddressAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let secondVc = storyboard.instantiateViewController(identifier: "MapViewController") as? MapViewController{
            secondVc.delegate = self
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
    
    @IBAction func btnAddCardAction(_ sender: Any) {
        viewAddCard.isHidden = false
        viewTop.isHidden = false
        viewThanku.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.viewAddCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    @IBAction func btnCancelAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewAddCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewAddCard.isHidden = true
            self.viewTop.isHidden = true
            self.viewThanku.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    @IBAction func btnCrossAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewAddCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewAddCard.isHidden = true
            self.viewTop.isHidden = true
            self.viewThanku.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    @IBAction func btnAddCardCardViewAction(_ sender: Any) {
        guard let cardNumber = txtCardNo.text, !cardNumber.isEmpty else {
            UIAlertController.showAlert(title: "Invalid Input", message: "Please enter a card number.", viewController: self)
            return
        }
        
        let trimmedCardNumber = cardNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        let numericOnly = trimmedCardNumber.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        if !numericOnly {
            UIAlertController.showAlert(title: "Invalid Card Number", message: "The card number must contain only digits.", viewController: self)
            return
        }
        
        if trimmedCardNumber.count < 13 || trimmedCardNumber.count > 19 {
            UIAlertController.showAlert(title: "Invalid Card Number", message: "The card number must be between 13 and 19 digits long.", viewController: self)
            return
        }
        let newCard: [String: String] = ["cardNo": trimmedCardNumber]
        sharedPaymentCards.append(newCard)
        tblView.reloadData()
        btnCrossAction(self)
    }
    
    
}
