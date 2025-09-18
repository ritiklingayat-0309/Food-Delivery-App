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
    let originalLineColor = UIColor(
        red: 246 / 255,
        green: 246 / 255,
        blue: 246 / 255,
        alpha: 1.0
    )

    /// Selected line color (#707070)
    let selectedLineColor = UIColor(
        red: 112 / 255,
        green: 112 / 255,
        blue: 112 / 255,
        alpha: 1.0
    )

    // MARK: - IBOutlets
    // Thank You page
    @IBOutlet weak var viewThanku: UIView!
    @IBOutlet weak var btnCancelX: UIButton!
    @IBOutlet weak var btnTrackMyOrder: UIButton!
    @IBOutlet weak var btnBackToHome: UIButton!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var lbllocThankYou: UILabel!
    @IBOutlet weak var lbllocForYourOrder: UILabel!
    @IBOutlet weak var lbllocYourOrder: UILabel!

    // Card view
    @IBOutlet weak var lbllocAddCartdebit: UILabel!
    @IBOutlet weak var lbllocExpiry: UILabel!
    @IBOutlet weak var lblocYouCan: UILabel!
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
    @IBOutlet weak var lbllocDeliveryAddress: UILabel!
    @IBOutlet weak var lblChangeAddress: UILabel!
    @IBOutlet weak var btnChangeAddress: UIButton!
    @IBOutlet weak var btnSendOrder: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lbllocPaymentMethod: UILabel!
    @IBOutlet weak var lbllocTotal: UILabel!
    @IBOutlet weak var lbllocDiscount: UILabel!
    @IBOutlet weak var lbllocDeliveryCost: UILabel!
    @IBOutlet weak var lbllocSubTotal: UILabel!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var viewLineDummy: UIView!

    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPaymentDetails()  // **Change:** Fetch data from Core Data when the view appears
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set navigation title with back button
        let localizedTitle = LocalizationManager.shared.localizedString(
            forKey: Main.checkOut.navTitile
        )
        setLeftAlignedTitleWithBack(
            localizedTitle,
            target: self,
            action: #selector(backButtonTapped)
        )

        // Apply borders and padding to relevant text fields and buttons
        EditStyle.setborder(textfields: [
            btnSendOrder, btnTrackMyOrder, btnAddCardCardView, txtExpMonth,
            txtExpYear, txtSecurityCode, txtFirstName, txtLastName, txtCardNo,
        ])
        EditStyle.setPadding(
            textFields: [
                txtSecurityCode, txtExpYear, txtExpMonth, txtFirstName,
                txtLastName, txtCardNo,
            ],
            paddingWidth: 28
        )

        // Register table view cells
        tblView.register(
            UINib(
                nibName: Main.CellIdentifier.CashOnDeliveryTableViewCell,
                bundle: nil
            ),
            forCellReuseIdentifier: Main.CellIdentifier
                .CashOnDeliveryTableViewCell
        )
        tblView.register(
            UINib(nibName: Main.CellIdentifier.GmailTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifier.GmailTableViewCell
        )
        tblView.register(
            UINib(nibName: Main.CellIdentifier.VisaTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifier.VisaTableViewCell
        )

        // Hide certain views initially
        viewThanku.isHidden = true
        viewTop.isHidden = true
        viewAddCard.isHidden = true
        styleCardLikeView(viewAddCard)
        styleCardLikeView(viewScroll)

        // Set saved address if available

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
        setUpLocalization()
        if let savedAddress = UserDefaults.standard.string(
            forKey: "savedAddress"
        ) {
            lblChangeAddress.text = savedAddress
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
        applyTheme()
    }

    func setUpLocalization() {
        lbllocDeliveryAddress.text = LocalizationManager.shared.localizedString(
            forKey: Main.checkOut.deliveryAddress
        )
        lblChangeAddress.text = LocalizationManager.shared.localizedString(
            forKey: Main.checkOut.changeAddress
        )
        btnSendOrder.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.checkOut.btnSendOrder
            ),
            for: .normal
        )
        lbllocPaymentMethod.text = LocalizationManager.shared.localizedString(
            forKey: Main.checkOut.paymentMethod
        )
        lbllocTotal.text = LocalizationManager.shared.localizedString(
            forKey: Main.checkOut.total
        )
        lbllocDiscount.text = LocalizationManager.shared.localizedString(
            forKey: Main.checkOut.discount
        )
        lbllocDeliveryCost.text = LocalizationManager.shared.localizedString(
            forKey: Main.checkOut.deliveryCost
        )
        lbllocSubTotal.text = LocalizationManager.shared.localizedString(
            forKey: Main.checkOut.subTotal
        )
        btnAddCard.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.checkOut.btnAddCard
            ),
            for: .normal
        )

        lbllocThankYou.text = LocalizationManager.shared.localizedString(
            forKey: Main.checkOut.thankyou
        )
        lbllocForYourOrder.text = LocalizationManager.shared.localizedString(
            forKey: Main.checkOut.forYourOrder
        )
        lbllocYourOrder.text = LocalizationManager.shared.localizedString(
            forKey: Main.checkOut.yourOrder
        )
        btnTrackMyOrder.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.checkOut.btnTrakMyOrder
            ),
            for: .normal
        )
        btnBackToHome.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.checkOut.btnBakcToHome
            ),
            for: .normal
        )

        lbllocAddCartdebit.text = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.lbladdcredi
        )
        lbllocExpiry.text = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.lblexpiry
        )
        lblocYouCan.text = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.lblyoucanremove
        )

        txtCardNo.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.txtCardNO
        )
        txtExpMonth.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.txtexpirymonth
        )
        txtExpYear.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.txtexpiryyear
        )
        txtSecurityCode.placeholder = LocalizationManager.shared
            .localizedString(forKey: Main.PaymentDetails.txtSecurity)
        txtFirstName.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.txtfirstname
        )
        txtLastName.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.txtlastname
        )
        btnAddCardCardView.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.PaymentDetails.btnAddcard
            ),
            for: .normal
        )
        btnChangeAddress.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.checkOut.btnchageAdd
            ),
            for: .normal
        )

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
        self.tabBarController?.tabBar.isHidden = false
        let storyboard = UIStoryboard(
            name: Main.StoryboardIdentifier.HomeStoryboard,
            bundle: nil
        )
        if let secodVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllerIdentifier.HomeViewController
        ) as? HomeViewController {
            navigationController?.pushViewController(secodVc, animated: true)
        }
    }

    /// Opens MapViewController to change address
    @IBAction func btnChangeAddressAction(_ sender: Any) {
        let storyboard = UIStoryboard(
            name: Main.StoryboardIdentifier.MoreStoryboard,
            bundle: nil
        )
        if let secondVc = storyboard.instantiateViewController(
            identifier: Main.ViewControllerIdentifier.MapViewController
        ) as? MapViewController {
            secondVc.delegate = self
            self.navigationController?.pushViewController(
                secondVc,
                animated: true
            )
        }
    }

    private func clearCardForm() {
        txtCardNo.text = ""
        txtExpMonth.text = ""
        txtExpYear.text = ""
        txtSecurityCode.text = ""
        txtFirstName.text = ""
        txtLastName.text = ""
    }

    /// Shows the Add Card view
    @IBAction func btnAddCardAction(_ sender: Any) {
        clearCardForm()
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
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }

    /// Handles cross button tap to close Add Card view
    @IBAction func btnCrossAction(_ sender: Any) {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.viewAddCard.transform = CGAffineTransform(
                    translationX: 0,
                    y: self.view.frame.height
                )
            }
        ) { _ in
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
        //  Prepare current year and month once
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let currentMonth = calendar.component(.month, from: Date())

        // Validate inputs
        switch true {
        case cardNumber.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.invalidInput,
                messageKey: Main.AlertMessage.emptyLastName
            )

        case cardNumber.rangeOfCharacter(
            from: CharacterSet.decimalDigits.inverted
        ) != nil:
            showAlert(
                titleKey: Main.AlertTitle.invalidInput,
                messageKey: Main.AlertMessage.invalidCardDigits
            )

        case cardNumber.count != 16:
            showAlert(
                titleKey: Main.AlertTitle.invalidInput,
                messageKey: Main.AlertMessage.invalidCardLength
            )

        case expiryMonth.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.emptyExpiryMonth
            )

        case expiryMonth.rangeOfCharacter(
            from: CharacterSet.decimalDigits.inverted
        ) != nil || expiryMonth.count != 2:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.expMonthvalid
            )

        case Int(expiryMonth) == nil || Int(expiryMonth)! < 1
            || Int(expiryMonth)! > 12:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.exYearValid
            )

        case expiryYear.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.emptyExpiryYear
            )

        case expiryYear.rangeOfCharacter(
            from: CharacterSet.decimalDigits.inverted
        ) != nil || expiryYear.count != 4:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.yearRange
            )

        case Int(expiryMonth) != nil && Int(expiryYear) != nil
            && ((Int(expiryYear)! < currentYear)
                || (Int(expiryYear)! == currentYear
                    && Int(expiryMonth)! < currentMonth)):
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.yearExp2
            )

        case securityCode.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.emptySecurityCode
            )

        case securityCode.rangeOfCharacter(
            from: CharacterSet.decimalDigits.inverted
        ) != nil:
            showAlert(
                titleKey: Main.AlertTitle.invalidSecurityCode,
                messageKey: Main.AlertMessage.invalidSecurityCodeDigits
            )

        case securityCode.count < 3 || securityCode.count > 4:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.invalidSecurityCodeLength
            )

        case firstName.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.invalidInput,
                messageKey: Main.AlertMessage.emptyFirstName
            )

        case firstName.rangeOfCharacter(from: allowedNameCharacters.inverted)
            != nil:
            showAlert(
                titleKey: Main.AlertTitle.invalidInput,
                messageKey: Main.AlertMessage.invalidFirstName
            )

        case lastName.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.invalidInput,
                messageKey: Main.AlertMessage.emptyLastName
            )

        case lastName.rangeOfCharacter(from: allowedNameCharacters.inverted)
            != nil:
            showAlert(
                titleKey: Main.AlertTitle.invalidInput,
                messageKey: Main.AlertMessage.invalidLastName
            )

        default:
            // Check for duplicate card
            if CoreDataManager.shared.isCardAlreadyExists(
                cardNumber: cardNumber
            ) {
                showAlert(
                    titleKey: Main.AlertTitle.duplicateCard,
                    messageKey: Main.AlertMessage.duplicateCard
                )
                return
            }

            // Add new card to shared payment cards and reload table
            CoreDataManager.shared.savePaymentDetails(
                cardNumber: cardNumber,
                securityCode: securityCode,
                firstName: firstName,
                lastName: lastName,
                expiryMonth: expiryMonth,
                expiryYear: expiryYear
            )

            // **Change:** Fetch the updated list of payment details
            fetchPaymentDetails()
            tblView.reloadData()
            btnCrossAction(self)
        }
    }
}
