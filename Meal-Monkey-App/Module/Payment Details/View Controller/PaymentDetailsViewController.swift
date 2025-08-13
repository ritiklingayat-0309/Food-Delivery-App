//
//  PaymentDetailsViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import UIKit
var sharedPaymentCards: [[String: String]] = []
class PaymentDetailsViewController: UIViewController,PaymentDetailsTableViewCellDelegate {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnAddAnotherCart: UIButton!
    @IBOutlet weak var ViewTop: UIView!
    //inside the view
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var txtCardNo: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtExpiryYear: UITextField!
    @IBOutlet weak var txtExpiryMonth: UITextField!
    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet weak var btnAddCart: UIButton!
    @IBOutlet weak var viewAddCard: UIView!
    @IBOutlet weak var viewScroll: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload the table to reflect any changes from other controllers.
        tblView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "PaymentDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "PaymentDetailsTableViewCell")
        setLeftAlignedTitleWithBack("Payment Details", target: self, action: #selector(backButtonTapped))
        setCartButton(target: self, action: #selector(cartButtonTapped))
        ViewTop.isHidden = true
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
        EditStyle.setborder(textfields: [txtCardNo,txtSecurityCode,btnAddAnotherCart, txtFirstName,txtLastName,txtExpiryMonth,txtExpiryYear,btnAddCart])
        EditStyle.setPadding(textFields: [txtCardNo,txtSecurityCode, txtFirstName, txtLastName,txtExpiryMonth,txtExpiryYear], paddingWidth: 29)
    }
    
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddAnotherCardFromTblAction(_ sender: Any) {
        viewAddCard.isHidden = false
        ViewTop.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewAddCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    @IBAction func btnCrossAction(_ sender: Any) {
        txtCardNo.text = ""
        txtSecurityCode.text = ""
        txtFirstName.text = ""
        txtLastName.text = ""
        txtExpiryMonth.text = ""
        txtExpiryYear.text = ""
        
        UIView.animate(withDuration: 0.3, animations: {
            self.viewAddCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewAddCard.isHidden = true
            self.ViewTop.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    @IBAction func btnAddCartAction(_ sender: Any) {
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
    
    
    func didTapDeleteButton(in cell: PaymentDetailsTableViewCell) {
        guard let indexPath = tblView.indexPath(for: cell) else { return }
        sharedPaymentCards.remove(at: indexPath.row)
        tblView.deleteRows(at: [indexPath], with: .fade)
    }
}
