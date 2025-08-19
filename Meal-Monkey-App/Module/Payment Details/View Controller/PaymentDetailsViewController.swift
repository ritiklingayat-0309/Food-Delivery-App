//
//  PaymentDetailsViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import UIKit

/// Shared array to store payment card details across the app
var arrsharedPaymentCards: [[String: String]] = []

/// ViewController that manages and displays payment details
class PaymentDetailsViewController: UIViewController, PaymentDetailsTableViewCellDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tblView: UITableView!                /// TableView to display added cards
    @IBOutlet weak var btnAddAnotherCart: UIButton!         /// Button to add another card
    @IBOutlet weak var ViewTop: UIView!                     /// Transparent top view shown during card entry
    @IBOutlet weak var lblEmptyCard: UILabel!               /// Label shown when no cards are available
    
    // Inside the card entry view
    @IBOutlet weak var btnCross: UIButton!                  /// Button to close card entry form
    @IBOutlet weak var txtCardNo: UITextField!              /// TextField for card number
    @IBOutlet weak var txtSecurityCode: UITextField!        /// TextField for CVV / security code
    @IBOutlet weak var txtFirstName: UITextField!           /// TextField for cardholder's first name
    @IBOutlet weak var txtLastName: UITextField!            /// TextField for cardholder's last name
    @IBOutlet weak var txtExpiryYear: UITextField!          /// TextField for expiry year
    @IBOutlet weak var txtExpiryMonth: UITextField!         /// TextField for expiry month
    @IBOutlet weak var Switch: UISwitch!                    /// UISwitch (not used in current logic)
    @IBOutlet weak var btnAddCart: UIButton!                /// Button to confirm card entry
    @IBOutlet weak var viewAddCard: UIView!                 /// Container view for add card form
    @IBOutlet weak var viewScroll: UIView!                  /// Scroll container with styling
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblView.reloadData()
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom cell
        tblView.register(UINib(nibName: "PaymentDetailsTableViewCell", bundle: nil),
                         forCellReuseIdentifier: "PaymentDetailsTableViewCell")
        
        // Set navigation bar buttons
        setLeftAlignedTitleWithBack("Payment Details", target: self, action: #selector(backButtonTapped))
        setCartButton(target: self, action: #selector(cartButtonTapped))
        
        // Hide card entry form initially
        ViewTop.isHidden = true
        viewAddCard.isHidden = true
        
        // Style add card view
        viewAddCard.layer.cornerRadius = 20
        viewAddCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewAddCard.layer.shadowColor = UIColor.black.cgColor
        viewAddCard.layer.shadowOpacity = 0.2
        viewAddCard.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewAddCard.layer.shadowRadius = 10
        
        // Style scroll view
        viewScroll.layer.cornerRadius = 20
        viewScroll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewScroll.layer.shadowColor = UIColor.black.cgColor
        viewScroll.layer.shadowOpacity = 0.2
        viewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewScroll.layer.shadowRadius = 10
        
        // Apply border & padding to textfields/buttons
        EditStyle.setborder(textfields: [txtCardNo, txtSecurityCode, btnAddAnotherCart,
                                         txtFirstName, txtLastName, txtExpiryMonth, txtExpiryYear, btnAddCart])
        EditStyle.setPadding(textFields: [txtCardNo, txtSecurityCode, txtFirstName,
                                          txtLastName, txtExpiryMonth, txtExpiryYear], paddingWidth: 29)
    }
    
    // MARK: - UI Update Helper
    /// Updates the UI depending on whether cards are available
    private func updateUI() {
        if arrsharedPaymentCards.isEmpty {
            lblEmptyCard.isHidden = false
            tblView.isHidden = true
        } else {
            lblEmptyCard.isHidden = true
            tblView.isHidden = false
            tblView.reloadData()
        }
    }
    
    // MARK: - Navigation Button Actions
    /// Opens Cart screen
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            secondVC.pagetype = .Cart
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    /// Goes back to previous screen
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Button Actions
    /// Opens add card form
    @IBAction func btnAddAnotherCardFromTblAction(_ sender: Any) {
        viewAddCard.isHidden = false
        ViewTop.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewAddCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    /// Closes add card form and clears textfields
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
    
    /// Validates and adds card to list
    @IBAction func btnAddCartAction(_ sender: Any) {
        let cardNumber = txtCardNo.text ?? ""
        let securityCode = txtSecurityCode.text ?? ""
        let firstName = txtFirstName.text ?? ""
        let lastName = txtLastName.text ?? ""
        let expiryMonth = txtExpiryMonth.text ?? ""
        let expiryYear = txtExpiryYear.text ?? ""
        let allowedNameCharacters = CharacterSet.letters.union(.whitespaces)
        
        switch true {
        case cardNumber.isEmpty:
            UIAlertController.showAlert(title: "Invalid Input",
                                        message: "Please enter a card number.",
                                        viewController: self)
            
        case cardNumber.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil:
            UIAlertController.showAlert(title: "Invalid Card Number",
                                        message: "The card number must contain only digits.",
                                        viewController: self)
            
        case cardNumber.count != 16:
            UIAlertController.showAlert(title: "Invalid Card Number",
                                        message: "The card number must be exactly 16 digits long.",
                                        viewController: self)
            
        case expiryMonth.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter the expiry month.",
                                        viewController: self)
            
        case expiryYear.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter the expiry year.",
                                        viewController: self)
            
        case securityCode.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter the security code.",
                                        viewController: self)
            
        case securityCode.count < 3 || securityCode.count > 4:
            UIAlertController.showAlert(title: "Error",
                                        message: "The security code must be 3 or 4 digits long.",
                                        viewController: self)
            
        case firstName.isEmpty:
            UIAlertController.showAlert(title: "Invalid Input",
                                        message: "Please enter the card holder's first name.",
                                        viewController: self)
            
        case firstName.rangeOfCharacter(from: allowedNameCharacters.inverted) != nil:
            UIAlertController.showAlert(title: "Invalid Input",
                                        message: "Please enter a valid first name using letters",
                                        viewController: self)
            
        case lastName.isEmpty:
            UIAlertController.showAlert(title: "Invalid Input",
                                        message: "Please enter the cardholder's last name.",
                                        viewController: self)
            
        case lastName.rangeOfCharacter(from: allowedNameCharacters.inverted) != nil:
            UIAlertController.showAlert(title: "Invalid Input",
                                        message: "Please enter a valid last name using letters.",
                                        viewController: self)
            
        default:
            let newCard: [String: String] = ["cardNo": cardNumber]
            arrsharedPaymentCards.append(newCard)
            tblView.reloadData()
            updateUI()
            btnCrossAction(self)
        }
    }
    
    // MARK: - PaymentDetailsTableViewCellDelegate
    /// Handles delete action from cell
    func didTapDeleteButton(in cell: PaymentDetailsTableViewCell) {
        guard let indexPath = tblView.indexPath(for: cell) else { return }
        arrsharedPaymentCards.remove(at: indexPath.row)
        tblView.deleteRows(at: [indexPath], with: .fade)
    }
}
