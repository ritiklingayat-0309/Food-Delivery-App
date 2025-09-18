//
//  ResetPasswordViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 01/08/25.
//

import UIKit

/// `ResetPasswordViewController`
///
/// This screen allows the user to reset their password by entering an email.
/// Steps:
/// - User enters their registered email.
/// - Input is validated (empty or invalid email check).
/// - On success, user navigates to the OTP verification screen (`SendOTPViewController`).
class ResetPasswordViewController: UIViewController {

    // MARK: - Outlets
    /// Text field for entering email address
    @IBOutlet weak var txtEmail: UITextField!
    /// Button to trigger reset password action
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var lblEnteryorEmail: UILabel!
    @IBOutlet weak var lblResetPassword: UILabel!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide the navigation back button (to avoid going back unintentionally)
        self.navigationItem.hidesBackButton = true
        // Apply padding inside email text field
        EditStyle.setPadding(textFields: [txtEmail], paddingWidth: 28)
        // Apply border styling to email text field and send button
        EditStyle.setborder(textfields: [txtEmail, btnSend])

        // Update texts for current language
        updateLocalization()

        // Observe language changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateLocalization),
            name: .languageChanged,
            object: nil
        )
        applyTheme()

        // ✅ Listen for theme changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
    }

    // MARK: - Localization
    @objc func updateLocalization() {
        lblResetPassword.text = LocalizationManager.shared.localizedString(
            forKey: Main.ResetPass.restitl1
        )
        lblEnteryorEmail.text = LocalizationManager.shared.localizedString(
            forKey: Main.ResetPass.restitl2
        )
        txtEmail.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.ResetPass.resttxt
        )
        btnSend.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.ResetPass.btnsend
            ),
            for: .normal
        )
    }

    // MARK: - Actions

    /// Action triggered when the "Send" button is pressed.
    /// Validates the email and, if valid, navigates to OTP screen.
    @IBAction func btnSendAction(_ sender: Any) {
        let email = txtEmail.text ?? ""

        // Validate email input
        switch true {
        case email.isEmpty:
            // Case 1: Empty input
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterEmail
            )

        case !email.isValidEmail:
            // Case 2: Invalid email format
            showAlert(
                titleKey: Main.AlertTitle.invalidEmail,
                messageKey: Main.AlertMessage.invalidEmail
            )

        default:
            // Case 3: Valid email
            print("Valid email entered.")
        }

        // Navigate to OTP verification screen
        let storyboard = UIStoryboard(
            name: Main.StoryboardIdentifier.LoginStoryboard,
            bundle: nil
        )
        if let secondVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllerIdentifier.SendOTPViewController
        ) as? SendOTPViewController {
            self.navigationController?.pushViewController(
                secondVc,
                animated: true
            )
        }
    }

    deinit {
        // ✅ Clean up notification
        NotificationCenter.default.removeObserver(
            self,
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
    }

    // MARK: - Theme
    @objc private func applyTheme() {
        let theme = ThemeManager.currentTheme
        view.backgroundColor = theme.backgroundColor
        lblResetPassword.textColor = theme.titleColor
        lblEnteryorEmail.textColor = theme.secondaryFontColor
        txtEmail.textColor = theme.labelColor
        txtEmail.backgroundColor = theme.secondaryFontColor.withAlphaComponent(
            0.1
        )
        btnSend.backgroundColor = theme.buttonColor
        btnSend.setTitleColor(theme.buttonTitle, for: .normal)
    }
}
