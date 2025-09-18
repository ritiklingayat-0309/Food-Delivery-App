//
//  SignUpViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 01/08/25.
//

import CoreData
import UIKit

/// Controller responsible for handling user sign-up flow,
/// including validation, saving data into Core Data,
/// and navigation to login screen if needed.
class SignUpViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var lblAddYourDetailsToSignUp: UILabel!
    @IBOutlet weak var txtName: UITextField!
    /// Text field for entering user's full name
    @IBOutlet weak var txtMobileNo: UITextField!
    /// Text field for entering mobile number
    @IBOutlet weak var txtEmail: UITextField!
    /// Text field for entering email address
    @IBOutlet weak var txtAddress: UITextField!
    /// Text field for entering address
    @IBOutlet weak var txtPassword: UITextField!
    /// Text field for entering password
    @IBOutlet weak var txtConfirmPassword: UITextField!
    /// Text field for confirming password
    @IBOutlet weak var btnSignUp: UIButton!
    /// Button to trigger sign-up process
    @IBOutlet weak var btnAlreadyHaveAccount: UIButton!
    /// Button to navigate back to login screen
    @IBOutlet weak var stackPasswordeye: UIStackView!
    /// Stack view containing password visibility toggle
    @IBOutlet weak var stackConfirmPaseye: UIStackView!
    /// Stack view containing confirm-password visibility toggle

    // MARK: - Properties
    var isPasswordVisible: Bool = false
    /// Tracks visibility state of password field
    var isConfirmPasswordVisible: Bool = false
    /// Tracks visibility state of confirm password field

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Hide default navigation back button
        self.navigationItem.hidesBackButton = true

        /// Apply padding and border styling to textfields & buttons
        EditStyle.setPadding(
            textFields: [
                txtName, txtMobileNo, txtEmail, txtAddress, txtPassword,
                txtConfirmPassword,
            ],
            paddingWidth: 28
        )
        EditStyle.setborder(textfields: [
            txtName, txtMobileNo, txtEmail, txtAddress, btnSignUp,
        ])
        EditStyle.addStackBorder(stackViews: [
            stackPasswordeye, stackConfirmPaseye,
        ])
        updateLocalization()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateLocalization),
            name: .languageChanged,
            object: nil
        )

        applyTheme()
        // Listen for theme changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )

    }

    @objc func updateLocalization() {
        lblSignUp.text = LocalizationManager.shared.localizedString(
            forKey: "signup_title_03"
        )
        lblAddYourDetailsToSignUp.text = LocalizationManager.shared
            .localizedString(forKey: "signup_subtitle_03")

        txtName.placeholder = LocalizationManager.shared.localizedString(
            forKey: "name_placeholder_03"
        )
        txtMobileNo.placeholder = LocalizationManager.shared.localizedString(
            forKey: "mobile_placeholder_03"
        )
        txtEmail.placeholder = LocalizationManager.shared.localizedString(
            forKey: "email_placeholder_03"
        )
        txtAddress.placeholder = LocalizationManager.shared.localizedString(
            forKey: "address_placeholder_03"
        )
        txtPassword.placeholder = LocalizationManager.shared.localizedString(
            forKey: "password_placeholder_03"
        )
        txtConfirmPassword.placeholder = LocalizationManager.shared
            .localizedString(forKey: "confirm_password_placeholder_03")

        btnSignUp.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: "signup_button_03"
            ),
            for: .normal
        )
        btnAlreadyHaveAccount.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: "already_have_account_03"
            ),
            for: .normal
        )
    }

    @objc private func applyTheme() {
        let theme = ThemeManager.currentTheme  // ✅ No .shared

        // Background
        view.backgroundColor = theme.backgroundColor

        // Buttons
        btnSignUp.backgroundColor = theme.buttonColor
        btnSignUp.setTitleColor(theme.buttonTitle, for: .normal)
        btnSignUp.layer.cornerRadius = 28
        btnSignUp.clipsToBounds = true
        btnSignUp.layer.borderWidth = 1
        btnSignUp.layer.borderColor = theme.borderColor.cgColor
        btnAlreadyHaveAccount.tintColor = theme.secondaryFontColor

        // TextFields Styling
        let textFields: [UITextField] = [
            txtName, txtEmail, txtMobileNo, txtAddress,
        ]
        for tf in textFields {
            tf.layer.cornerRadius = 28
            tf.layer.masksToBounds = true
            tf.layer.borderWidth = 1
            tf.layer.borderColor = theme.borderColor.cgColor
            tf.textColor = theme.labelColor
            tf.backgroundColor = theme.cellBackgroundColor

        }

        // StackViews (password, confirm password)
        let stacks: [UIStackView] = [stackPasswordeye, stackConfirmPaseye]
        for stack in stacks {
            stack.layer.cornerRadius = 28
            stack.layer.masksToBounds = true
            stack.layer.borderWidth = 1
            stack.layer.borderColor = theme.borderColor.cgColor
            stack.backgroundColor = theme.cellBackgroundColor
        }
    }

    // MARK: - Actions
    /// Toggle password visibility with eye icon button
    @IBAction func btnPasswordEyeAction(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible
        let imageName =
            isPasswordVisible ? Main.ImageName.eye : Main.ImageName.eyeSlash
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    /// Toggle confirm password visibility with eye icon button
    @IBAction func btnConfirPassEyeAction(_ sender: Any) {
        isConfirmPasswordVisible = !isConfirmPasswordVisible
        txtConfirmPassword.isSecureTextEntry = !isConfirmPasswordVisible
        let imageName =
            isConfirmPasswordVisible
            ? Main.ImageName.eye : Main.ImageName.eyeSlash
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    /// Navigate back to login screen if user already has an account
    @IBAction func btnAlreadyAcountLogin(_ sender: Any) {
        let storyboard = UIStoryboard(
            name: Main.StoryboardIdentifier.LoginStoryboard,
            bundle: nil
        )
        if (storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllerIdentifier.LoginViewController
        ) as? LoginViewController) != nil {
            self.navigationController?.popViewController(animated: true)
        }
    }

    /// Handles sign-up process including:
    /// - Validation of inputs
    /// - Core Data saving of new user
    /// - Displaying alerts
    @IBAction func btnSignUpAction(_ sender: Any) {
        let name = txtName.text ?? ""
        let email = txtEmail.text ?? ""
        let mobile = txtMobileNo.text ?? ""
        let address = txtAddress.text ?? ""
        let password = txtPassword.text ?? ""
        let confirmPassword = txtConfirmPassword.text ?? ""

        /// Validate user inputs using switch-case style
        switch true {
        case name.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterName
            )

        case email.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterEmail
            )

        case !email.isValidEmail:
            showAlert(
                titleKey: Main.AlertTitle.invalidEmail,
                messageKey: Main.AlertMessage.invalidEmail
            )

        case mobile.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterMobile
            )

        case mobile.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted)
            != nil:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.digitsOnly
            )

        case mobile.count != 10:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.mobileLength
            )

        case address.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterAddress
            )

        case password.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterPassword
            )

        case !password.isValidPassword:
            showAlert(
                titleKey: Main.AlertTitle.invalidPassword,
                messageKey: Main.AlertMessage.invalidPassword
            )

        case confirmPassword.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterConfirmPassword
            )

        case password != confirmPassword:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.passwordMismatch
            )

        default:
            /// Save user in Core Data
            guard
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            guard
                let userEntity = NSEntityDescription.entity(
                    forEntityName: "User",
                    in: managedContext
                )
            else { return }
            let user = NSManagedObject(
                entity: userEntity,
                insertInto: managedContext
            )
            user.setValue(name, forKey: "name")
            user.setValue(email, forKey: "email")
            user.setValue(mobile, forKey: "mobileNo")
            user.setValue(address, forKey: "address")
            user.setValue(password, forKey: "password")
            user.setValue(UUID(), forKey: "userID")

            do {
                /// Try saving user to Core Data
                try managedContext.save()
                print("User saved successfully!")

                /// Show success alert and pop back to login
                showAlert(
                    titleKey: "success",
                    messageKey: Main.AlertMessage.registrationSuccess
                ) {
                    self.navigationController?.popViewController(animated: true)
                }
            } catch let error as NSError {
                /// Handle error in saving user
                print("Could not save user. \(error), \(error.userInfo)")

                showAlert(
                    titleKey: Main.AlertTitle.error,
                    messageKey: Main.AlertMessage.registrationFailed
                )
            }
        }
    }
}
