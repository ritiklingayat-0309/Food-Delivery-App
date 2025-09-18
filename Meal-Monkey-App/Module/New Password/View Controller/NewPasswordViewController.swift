//
//  NewPasswordViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

/// `NewPasswordViewController`
/// Screen for setting a new password and confirming it.
/// Includes validation, password visibility toggle, and navigation
/// to the features screen once the password setup is complete.
class NewPasswordViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var lblEnterEmailToReviewPass: UILabel!
    @IBOutlet weak var lblNewPassword: UILabel!
    /// Stack view wrapping confirm password field
    @IBOutlet weak var stackConfimPass: UIStackView!

    /// Stack view wrapping new password field
    @IBOutlet weak var stackNewPass: UIStackView!

    /// Eye button for toggling new password visibility
    @IBOutlet weak var btneyeNewPass: UIButton!

    /// Text field for entering the new password
    @IBOutlet weak var txtNewPassword: UITextField!

    /// Eye button for toggling confirm password visibility
    @IBOutlet weak var btnEyeConfirmPas: UIButton!

    /// Text field for confirming the new password
    @IBOutlet weak var txtCofirmPassword: UITextField!

    /// Next button to validate and proceed
    @IBOutlet weak var btnNext: UIButton!

    // MARK: - State

    /// Tracks visibility of new password field
    var isPasswordVisible: Bool = false

    /// Tracks visibility of confirm password field
    var isConfirmPasswordVisible: Bool = false

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide the back button for this flow
        self.navigationItem.hidesBackButton = true

        // Apply UI styling using helper class
        EditStyle.setPadding(
            textFields: [txtNewPassword, txtCofirmPassword],
            paddingWidth: 28
        )
        EditStyle.setborder(textfields: [btnNext])
        EditStyle.addStackBorder(stackViews: [stackConfimPass, stackNewPass])

        updateLocalization()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateLocalization),
            name: .languageChanged,
            object: nil
        )
        applyTheme()

        // ✅ Observe theme changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
    }

    @objc func updateLocalization() {
        lblEnterEmailToReviewPass.text = LocalizationManager.shared
            .localizedString(forKey: Main.NewPassword.newpass2)
        lblNewPassword.text = LocalizationManager.shared.localizedString(
            forKey: Main.NewPassword.newpass1
        )
        //        stackConfimPass.accessibilityLabel = LocalizationManager.shared.localizedString(forKey: "confirm_password_title_03")

        txtNewPassword.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.NewPassword.txtnewpass
        )
        txtCofirmPassword.placeholder = LocalizationManager.shared
            .localizedString(forKey: Main.NewPassword.txtconfirmpass)

        btnNext.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.NewPassword.btnNext
            ),
            for: .normal
        )
    }

    @objc private func applyTheme() {
        let theme = ThemeManager.currentTheme
        view.backgroundColor = theme.backgroundColor
        lblNewPassword.textColor = theme.titleColor
        lblEnterEmailToReviewPass.textColor = theme.secondaryFontColor
        txtNewPassword.textColor = theme.labelColor
        txtCofirmPassword.textColor = theme.labelColor
        txtNewPassword.backgroundColor = theme.secondaryFontColor
            .withAlphaComponent(0.1)
        txtCofirmPassword.backgroundColor = theme.secondaryFontColor
            .withAlphaComponent(0.1)
        btnNext.backgroundColor = theme.buttonColor
        btnNext.setTitleColor(theme.buttonTitle, for: .normal)

        // Optional: match eye icons with theme
        btneyeNewPass.tintColor = theme.placeholderColor
        btnEyeConfirmPas.tintColor = theme.placeholderColor
    }

    deinit {
        // Remove observer
        NotificationCenter.default.removeObserver(
            self,
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
    }

    // MARK: - Actions
    /// Toggle confirm password visibility (eye button)
    @IBAction func btnEyeConfirmPasAction(_ sender: Any) {
        isConfirmPasswordVisible.toggle()
        txtCofirmPassword.isSecureTextEntry = !isConfirmPasswordVisible

        let imageName =
            isConfirmPasswordVisible
            ? Main.ImageName.eye : Main.ImageName.eyeSlash
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    /// Toggle new password visibility (eye button)
    @IBAction func btnEyeNewPasswordAction(_ sender: Any) {
        isPasswordVisible.toggle()
        txtNewPassword.isSecureTextEntry = !isPasswordVisible

        let imageName =
            isPasswordVisible ? Main.ImageName.eye : Main.ImageName.eyeSlash
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    /// Validate inputs and navigate to Features screen
    @IBAction func btnNextAction(_ sender: Any) {
        let password = txtNewPassword.text ?? ""
        let confirmPassword = txtCofirmPassword.text ?? ""

        switch true {
        case password.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterPassword
            )

        case !password.isValidPassword:
            showAlert(
                titleKey: Main.AlertTitle.error,
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
            print("All validations passed. Continue registration.")
        }

        // Navigate to FeaturesViewController if validations are done
        let storyboard = UIStoryboard(
            name: Main.StoryboardIdentifier.FeaturesStoryboard,
            bundle: nil
        )
        if let secondVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllerIdentifier.FeaturesViewController
        ) as? FeaturesViewController {
            self.navigationController?.pushViewController(
                secondVc,
                animated: true
            )
        }
    }
}
