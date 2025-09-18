//
//  PaymentDetailsViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import Lottie
import UIKit

/// ViewController that manages and displays payment details
class PaymentDetailsViewController: UIViewController,
    PaymentDetailsTableViewCellDelegate
{

    @IBOutlet weak var lblAddCredit: UILabel!
    @IBOutlet weak var lblExpiry: UILabel!
    @IBOutlet weak var lblYouCanRemove: UILabel!

    @IBOutlet weak var scrollview: UIScrollView!
    // MARK: - Outlets
    @IBOutlet weak var tblView: UITableView!
    /// TableView to display added cards
    @IBOutlet weak var btnAddAnotherCart: UIButton!
    /// Button to add another card
    @IBOutlet weak var ViewTop: UIView!
    /// Transparent top view shown during card entry

    @IBOutlet weak var lblCustmizeYourPaymentMethod: UILabel!
    // Inside the card entry view
    @IBOutlet weak var btnCross: UIButton!
    /// Button to close card entry form
    @IBOutlet weak var txtCardNo: UITextField!
    /// TextField for card number
    @IBOutlet weak var txtSecurityCode: UITextField!
    /// TextField for CVV / security code
    @IBOutlet weak var txtFirstName: UITextField!
    /// TextField for cardholder's first name
    @IBOutlet weak var txtLastName: UITextField!
    /// TextField for cardholder's last name
    @IBOutlet weak var txtExpiryYear: UITextField!
    /// TextField for expiry year
    @IBOutlet weak var txtExpiryMonth: UITextField!
    /// TextField for expiry month
    @IBOutlet weak var Switch: UISwitch!
    /// UISwitch (not used in current logic)
    @IBOutlet weak var btnAddCart: UIButton!
    /// Button to confirm card entry
    @IBOutlet weak var viewAddCard: UIView!
    /// Container view for add card form
    @IBOutlet weak var viewScroll: UIView!
    /// Scroll container with styling

    var paymentDetails: [PaymentDetails] = []

    // For Animation
    private var emptyCardAnimationView: LottieAnimationView?
    private var emptyCardLabel: UILabel?

    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblView.reloadData()
        fetchPaymentDetails()
        updateUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register custom cell
        tblView.register(
            UINib(
                nibName: Main.CellIdentifier.PaymentDetailsTableViewCell,
                bundle: nil
            ),
            forCellReuseIdentifier: Main.CellIdentifier
                .PaymentDetailsTableViewCell
        )

        // Set navigation bar buttons
        setLeftAlignedTitleWithBack(
            LocalizationManager.shared.localizedString(
                forKey: Main.PaymentDetails.navtitle
            ),
            target: self,
            action: #selector(backButtonTapped)
        )
        setCartButton(target: self, action: #selector(cartButtonTapped))

        // Hide card entry form initially
        ViewTop.isHidden = true
        viewAddCard.isHidden = true

        //style
        styleCardLikeView(viewAddCard)
        styleCardLikeView(viewScroll)

        // Apply border & padding to textfields/buttons
        EditStyle.setborder(textfields: [
            txtCardNo, txtSecurityCode, btnAddAnotherCart,
            txtFirstName, txtLastName, txtExpiryMonth, txtExpiryYear,
            btnAddCart,
        ])
        EditStyle.setPadding(
            textFields: [
                txtCardNo, txtSecurityCode, txtFirstName,
                txtLastName, txtExpiryMonth, txtExpiryYear,
            ],
            paddingWidth: 29
        )
        // Setup Animation
        setUpAnimations()

        languageDidChange()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(languageDidChange),
            name: .languageChanged,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )

        // Apply theme initially
        applyTheme()

    }

    @objc func applyTheme() {
        let theme = ThemeManager.currentTheme

        // MARK: - Labels
        lblExpiry.textColor = theme.primaryFontColor
        lblAddCredit.textColor = theme.primaryFontColor
        lblCustmizeYourPaymentMethod.textColor = theme.primaryFontColor
        lblYouCanRemove.textColor = theme.secondaryFontColor

        // MARK: - Buttons
        btnAddAnotherCart.backgroundColor = theme.mainColor
        btnAddAnotherCart.setTitleColor(theme.buttonTitle, for: .normal)
        btnAddCart.backgroundColor = theme.mainColor
        btnAddCart.setTitleColor(theme.accentColor, for: .normal)
        btnCross.tintColor = theme.mainColor

        // MARK: - TextFields
        let textFields = [
            txtFirstName, txtLastName, txtCardNo, txtExpiryMonth, txtExpiryYear,
            txtSecurityCode,
        ]
        textFields.forEach { tf in
            tf?.layer.borderColor = UIColor.gray.cgColor
            tf?.layer.borderWidth = 1
            tf?.backgroundColor = theme.cellBackgroundColor
            tf?.textColor = theme.primaryFontColor
            tf?.attributedPlaceholder = NSAttributedString(
                string: tf?.placeholder ?? "",
                attributes: [
                    NSAttributedString.Key.foregroundColor: theme
                        .placeholderColor
                ]
            )
        }

        // MARK: - TableView
        tblView.reloadData()
    }

    @objc func languageDidChange() {
        lblCustmizeYourPaymentMethod.text = LocalizationManager.shared
            .localizedString(forKey: Main.PaymentDetails.customizePay)
        btnAddCart.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.PaymentDetails.btnAddcard
            ),
            for: .normal
        )
        btnAddAnotherCart.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.PaymentDetails.btnAddAnother
            ),
            for: .normal
        )
        txtCardNo.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.txtCardNO
        )
        txtSecurityCode.placeholder = LocalizationManager.shared
            .localizedString(forKey: Main.PaymentDetails.txtSecurity)
        txtFirstName.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.txtfirstname
        )
        txtLastName.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.txtlastname
        )
        txtExpiryMonth.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.txtexpirymonth
        )
        txtExpiryYear.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.txtexpiryyear
        )
        lblAddCredit.text = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.lbladdcredi
        )
        lblExpiry.text = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.lblexpiry
        )
        lblYouCanRemove.text = LocalizationManager.shared.localizedString(
            forKey: Main.PaymentDetails.lblyoucanremove
        )
        tblView.reloadData()
    }

    func setUpAnimations() {
        // MARK: Setup Lottie Animation for Empty State
        emptyCardAnimationView = LottieAnimationView(name: "Payment Failed")  // your JSON
        if let emptyCardAnimationView = emptyCardAnimationView {
            emptyCardAnimationView.contentMode = .scaleAspectFit
            emptyCardAnimationView.loopMode = .loop
            emptyCardAnimationView.isHidden = true
            emptyCardAnimationView.translatesAutoresizingMaskIntoConstraints =
                false
            view.addSubview(emptyCardAnimationView)

            NSLayoutConstraint.activate([
                emptyCardAnimationView.centerXAnchor.constraint(
                    equalTo: view.centerXAnchor
                ),
                emptyCardAnimationView.centerYAnchor.constraint(
                    equalTo: view.centerYAnchor,
                    constant: -50
                ),
                emptyCardAnimationView.widthAnchor.constraint(
                    equalTo: view.widthAnchor,
                    multiplier: 0.7
                ),
                emptyCardAnimationView.heightAnchor.constraint(
                    equalToConstant: 220
                ),
            ])

            // Add label under animation
            let label = UILabel()
            label.text = LocalizationManager.shared.localizedString(
                forKey: Main.PaymentDetails.noCardsave
            )
            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            label.textColor = .darkGray
            label.textAlignment = .center
            label.isHidden = true
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)

            NSLayoutConstraint.activate([
                label.topAnchor.constraint(
                    equalTo: emptyCardAnimationView.bottomAnchor,
                    constant: 12
                ),
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
            emptyCardLabel = label
        }
    }

    private func fetchPaymentDetails() {
        self.paymentDetails = CoreDataManager.shared.fetchPaymentDetails()
        updateUI()
    }

    // MARK: - UI Update Helper
    /// Updates the UI depending on whether cards are available
    private func updateUI() {
        if paymentDetails.isEmpty {
            tblView.isHidden = true
            emptyCardAnimationView?.isHidden = false
            emptyCardAnimationView?.play()
            emptyCardLabel?.isHidden = false
        } else {
            tblView.isHidden = false
            tblView.reloadData()
            emptyCardAnimationView?.stop()
            emptyCardAnimationView?.isHidden = true
            emptyCardLabel?.isHidden = true
        }
    }

    func styleCardLikeView(_ view: UIView) {
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 10
    }

    // MARK: - Navigation Button Actions
    /// Opens Cart screen
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(
            name: Main.StoryboardIdentifier.MenuListStoryboard,
            bundle: nil
        )
        if let secondVC = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllerIdentifier.CartViewController
        ) as? CartViewController {
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
        emptyCardAnimationView?.stop()
        emptyCardAnimationView?.isHidden = true
        emptyCardLabel?.isHidden = true
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
        updateUI()
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
        //  Prepare current year and month once
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let currentMonth = calendar.component(.month, from: Date())

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

            // **Change:** Call CoreDataManager to save the data
            CoreDataManager.shared.savePaymentDetails(
                cardNumber: cardNumber,
                securityCode: securityCode,
                firstName: firstName,
                lastName: lastName,
                expiryMonth: expiryMonth,
                expiryYear: expiryYear
            )
            tblView.reloadData()
            updateUI()
            self.fetchPaymentDetails()
            btnCrossAction(self)
        }
    }

    // MARK: - PaymentDetailsTableViewCellDelegate
    /// Handles delete action from cell
    func didTapDeleteButton(in cell: PaymentDetailsTableViewCell) {
        guard let indexPath = tblView.indexPath(for: cell) else { return }
        let paymentDetailToDelete = paymentDetails[indexPath.row]
        CoreDataManager.shared.deletePaymentDetail(paymentDetailToDelete)
        paymentDetails.remove(at: indexPath.row)
        tblView.deleteRows(at: [indexPath], with: .fade)
        updateUI()
    }
}
