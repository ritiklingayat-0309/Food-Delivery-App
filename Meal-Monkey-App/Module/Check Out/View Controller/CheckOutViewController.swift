//
//  CheckOutViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import UIKit

/// `CheckOutViewController` manages the checkout process including displaying
/// subtotal, delivery cost, total, selecting payment method, adding cards,
/// changing address, and showing thank you page after order submission.
class CheckOutViewController: UIViewController, MapViewControllerDelegate {
    
    // MARK: - Properties
    /// Array of saved card names
    var arrCards : [String] = ["Card -1 ", "card -2 ", "card -3 "]
    
    /// Subtotal amount of the order
    var subtotal: Double?
    
    /// Delivery cost for the order
    var deliveryCost: Double?
    
    /// Total amount (subtotal + delivery)
    var total: Double?
    
    /// Index of the selected payment method
    var selectedPaymentIndex: Int = 0
    
    var paymentDetails: [PaymentDetails] = []
    
    /// Default line color (#F6F6F6)
    let originalLineColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
    
    /// Selected line color (#707070)
    let selectedLineColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)
    
    // MARK: - IBOutlets
    
    // Thank You page
    @IBOutlet weak var viewThanku: UIView!
    @IBOutlet weak var btnCancelX: UIButton!
    @IBOutlet weak var btnTrackMyOrder: UIButton!
    @IBOutlet weak var btnBackToHome: UIButton!
    @IBOutlet weak var viewTop: UIView!
    
    // Card view
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
    
    // Checkout view
    @IBOutlet weak var lblChangeAddress: UILabel!
    @IBOutlet weak var btnChangeAddress: UIButton!
    @IBOutlet weak var btnSendOrder: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var viewLineDummy: UIView!
    
    // MARK: - Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            fetchPaymentDetails() // **Change:** Fetch data from Core Data when the view appears
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation title with back button
        setLeftAlignedTitleWithBack("CheckOut", target: self, action: #selector(backButtonTapped))
        
        // Apply borders and padding to relevant text fields and buttons
        EditStyle.setborder(textfields: [btnSendOrder,btnTrackMyOrder,btnAddCardCardView,txtExpMonth,txtExpYear,txtSecurityCode,txtFirstName,txtLastName,txtCardNo])
        EditStyle.setPadding(textFields: [txtSecurityCode,txtExpYear,txtExpMonth,txtFirstName,txtLastName,txtCardNo], paddingWidth: 28)
        
        // Register table view cells
        tblView.register(UINib(nibName: "CashOnDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "CashOnDeliveryTableViewCell")
        tblView.register(UINib(nibName: "GmailTableViewCell", bundle: nil), forCellReuseIdentifier: "GmailTableViewCell")
        tblView.register(UINib(nibName: "VisaTableViewCell", bundle: nil), forCellReuseIdentifier: "VisaTableViewCell")
        
        // Hide certain views initially
        viewThanku.isHidden = true
        viewTop.isHidden = true
        viewAddCard.isHidden = true
        styleCardLikeView(viewAddCard)
        styleCardLikeView(viewScroll)
        
        // Set saved address if available
        if let savedAddress = UserDefaults.standard.string(forKey: "savedAddress") {
            lblChangeAddress.text = savedAddress
        }
        
        // Set subtotal, delivery cost, and total labels
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
    
    private func fetchPaymentDetails() {
           self.paymentDetails = CoreDataManager.shared.fetchPaymentDetails()
           tblView.reloadData()
       }
    
    /// Applies rounded top corners and shadow to a given view.
    /// - Parameter view: The UIView to apply the styling
    func styleCardLikeView(_ view: UIView) {
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 10
    }
    
    // MARK: - Navigation
    
    /// Handles back button tap
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    /// Delegate method for selecting address from MapViewController
    /// - Parameter address: Selected address string
    func didSelectAddress(_ address: String) {
        lblChangeAddress.text = address
        UserDefaults.standard.set(address, forKey: "savedAddress")
    }
    
    // MARK: - IBActions
    
    /// Sends the order and shows the Thank You page
    @IBAction func btnSendOrderAction(_ sender: Any) {
        viewAddCard.isHidden = true
        viewTop.isHidden = false
        viewThanku.isHidden = false
        btnChangeAddress.isHidden = true
        viewLineDummy.backgroundColor = selectedLineColor
        UIView.animate(withDuration: 0.3) {
            self.viewAddCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    /// Tracks the order (implementation empty)
    @IBAction func btnTrackMyOrderAction(_ sender: Any) {
    }
    
    /// Returns to home page (implementation empty)
    @IBAction func btnBackToHomeAction(_ sender: Any) {
    }
    
    /// Opens MapViewController to change address
    @IBAction func btnChangeAddressAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let secondVc = storyboard.instantiateViewController(identifier: "MapViewController") as? MapViewController{
            secondVc.delegate = self
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
    
    /// Shows the Add Card view
    @IBAction func btnAddCardAction(_ sender: Any) {
        viewAddCard.isHidden = false
        viewTop.isHidden = false
        btnChangeAddress.isHidden = true
        // Change color
        viewLineDummy.backgroundColor = selectedLineColor
        viewThanku.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.viewAddCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    /// Cancels Add Card view
    @IBAction func btnCancelAction(_ sender: Any) {
       let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier: "OrderListViewController") as? OrderListViewController{
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
    
    /// Handles cross button tap to close Add Card view
    @IBAction func btnCrossAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewAddCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewAddCard.isHidden = true
            self.viewTop.isHidden = true
            self.viewThanku.isHidden = true
            self.btnChangeAddress.isHidden = false
            self.tabBarController?.tabBar.isHidden = false
            self.viewLineDummy.backgroundColor = self.originalLineColor
        }
    }
    
    /// Adds a new card from the Card View
    @IBAction func btnAddCardCardViewAction(_ sender: Any) {
        let cardNumber = txtCardNo.text ?? ""
        let securityCode = txtSecurityCode.text ?? ""
        let firstName = txtFirstName.text ?? ""
        let lastName = txtLastName.text ?? ""
        let expiryMonth = txtExpMonth.text ?? ""
        let expiryYear = txtExpYear.text ?? ""
        let allowedNameCharacters = CharacterSet.letters.union(.whitespaces)
        
        // Validate inputs
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
            // Add new card to shared payment cards and reload table
            CoreDataManager.shared.savePaymentDetails(cardNumber: cardNumber,
                                                                  securityCode: securityCode,
                                                                  firstName: firstName,
                                                                  lastName: lastName,
                                                                  expiryMonth: expiryMonth,
                                                                  expiryYear: expiryYear)
                        
                        // **Change:** Fetch the updated list of payment details
            fetchPaymentDetails()
            tblView.reloadData()
            btnCrossAction(self)
        }
    }
}
