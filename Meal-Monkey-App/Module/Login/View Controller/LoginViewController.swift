//
//  LoginViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 31/07/25.
//

import CoreData
import UIKit

/// `LoginViewController` handles user login functionality including email/password login,
/// password visibility toggle, login with Facebook/Google, and navigation to SignUp or ResetPassword screens.
class LoginViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var lblOrWith: UILabel!
    @IBOutlet weak var lblAddyouDetails: UILabel!
    @IBOutlet weak var lblLogin: UILabel!
    /// Login button

    @IBOutlet weak var btnLogin: UIButton!
    /// Forget password button
    ///
    @IBOutlet weak var btnForget: UIButton!

    /// Login with Facebook button
    @IBOutlet weak var btnLoginWithFaceBook: UIButton!

    /// Login with Google button
    @IBOutlet weak var btnLoginWithGoogle: UIButton!

    /// Sign up button
    @IBOutlet weak var btnSignIn: UIButton!

    /// Email text field
    @IBOutlet weak var txtEmail: UITextField!

    /// Password text field
    @IBOutlet weak var txtPassword: UITextField!

    /// Password visibility toggle button
    @IBOutlet weak var btnEye: UIButton!

    /// Flag to track password visibility state
    var isPasswordVisible: Bool = false

    /// Stack view containing password field and eye button
    @IBOutlet weak var stackViewPass: UIStackView!

    // MARK: - View Lifecycle

    /// Called after the view has been loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

        // Apply styles to UI elements
        EditStyle.addStackBorder(stackViews: [stackViewPass])
        EditStyle.setPadding(
            textFields: [txtEmail, txtPassword],
            paddingWidth: 28
        )
        EditStyle.setborder(textfields: [
            txtEmail, btnLogin, btnForget, btnLoginWithFaceBook,
            btnLoginWithGoogle,
        ])

        // Hide tab bar on login screen
        self.tabBarController?.tabBar.isHidden = true

        //for localization
        updateLocalization()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateLocalization),
            name: .languageChanged,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: Notification.Name("themeChanged"),
            object: nil
        )
        applyTheme()
    }

    @objc func updateLocalization() {
        lblLogin.text = LocalizationManager.shared.localizedString(
            forKey: Main.Login.loginTitle1
        )
        lblAddyouDetails.text = LocalizationManager.shared.localizedString(
            forKey: Main.Login.loginTitle2
        )
        lblOrWith.text = LocalizationManager.shared.localizedString(
            forKey: Main.Login.orWith
        )

        btnLogin.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.Login.btnlogin
            ),
            for: .normal
        )
        btnForget.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.Login.btnForgest
            ),
            for: .normal
        )
        btnLoginWithFaceBook.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.Login.btnWithface
            ),
            for: .normal
        )
        btnLoginWithGoogle.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.Login.btnWithgo
            ),
            for: .normal
        )
        btnSignIn.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.Login.btnsignup
            ),
            for: .normal
        )

        txtEmail.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.Login.txtemail
        )
        txtPassword.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.Login.txtpass
        )
    }

    // MARK: - IBActions

    /// Toggle password visibility
    /// - Parameter sender: UIButton that triggered the action
    @IBAction func btnEyeAction(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible
        let imageName =
            isPasswordVisible ? Main.ImageName.eye : Main.ImageName.eyeSlash
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    /// Handle login button action
    /// - Parameter sender: UIButton that triggered the action
    @IBAction func btnLoginAction(_ sender: Any) {
        let email = txtEmail.text ?? ""
        let pass = txtPassword.text ?? ""

        switch true {
        case email.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterName
            )

        case !email.isValidEmail:
            showAlert(
                titleKey: Main.AlertTitle.invalidEmail,
                messageKey: Main.AlertMessage.invalidEmail
            )

        case pass.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterPassword
            )

        case !pass.isValidPassword:
            showAlert(
                titleKey: Main.AlertTitle.invalidPassword,
                messageKey: Main.AlertMessage.invalidPassword
            )

        default:
            // Perform Core Data fetch for login
            guard
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(
                entityName: "User"
            )
            let predicate = NSPredicate(
                format: "email == %@ AND password == %@",
                email,
                pass
            )
            fetchRequest.predicate = predicate

            do {
                let users = try managedContext.fetch(fetchRequest)
                if let loggedInUser = users.first {
                    print(
                        "Login successful for user: \(loggedInUser.value(forKey: "name") ?? "")"
                    )
                    if let userID = loggedInUser.value(forKey: "userID")
                        as? UUID
                    {
                        UserDefaults.standard.set(
                            userID.uuidString,
                            forKey: "loggedInUserID"
                        )
                    }
                    self.showMainTabBar()
                    UserDefaults.standard.set("true", forKey: "LoginStatus")
                } else {
                    showAlert(
                        titleKey: Main.AlertTitle.error,
                        messageKey: Main.AlertMessage.usrNotFound
                    )
                }
            } catch {
                print("Failed to fetch user: \(error.localizedDescription)")
                showAlert(
                    titleKey: Main.AlertTitle.error,
                    messageKey: Main.AlertMessage.loginFailed
                )
            }
        }
    }

    // MARK: - Private Methods

    /// Show the main tab bar controller after successful login
    private func showMainTabBar() {
        let storyboard = UIStoryboard(
            name: Main.StoryboardIdentifier.HomeStoryboard,
            bundle: nil
        )
        if let tabBarController = storyboard.instantiateViewController(
            withIdentifier: "TabBarViewController"
        ) as? UITabBarController {
            tabBarController.selectedIndex = 2
            if let windowScene = UIApplication.shared.connectedScenes.first
                as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate
            {
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }

    /// Navigate to ResetPassword screen
    /// - Parameter sender: UIButton that triggered the action
    @IBAction func btnForgetAction(_ sender: Any) {
        let storyboard = UIStoryboard(
            name: Main.StoryboardIdentifier.LoginStoryboard,
            bundle: nil
        )
        if let secondVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllerIdentifier
                .ResetPasswordViewController
        ) as? ResetPasswordViewController {
            self.navigationController?.pushViewController(
                secondVc,
                animated: true
            )
        }
    }

    /// Placeholder for login with Facebook action
    /// - Parameter sender: UIButton that triggered the action
    @IBAction func btnLoginWithFacebookAction(_ sender: Any) {
    }

    /// Placeholder for login with Google action
    /// - Parameter sender: UIButton that triggered the action
    @IBAction func btnLoginWithGoogleAction(_ sender: Any) {
    }

    /// Navigate to SignUp screen
    /// - Parameter sender: UIButton that triggered the action
    @IBAction func btnSignInAction(_ sender: Any) {
        let storyboard = UIStoryboard(
            name: Main.StoryboardIdentifier.LoginStoryboard,
            bundle: nil
        )
        if let secondVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllerIdentifier.SignUpViewController
        ) as? SignUpViewController {
            self.navigationController?.pushViewController(
                secondVc,
                animated: true
            )
        }
    }

    @objc private func applyTheme() {
        let theme = ThemeManager.currentTheme
        view.backgroundColor = theme.backgroundColor
        // Labels
        [lblLogin, lblAddyouDetails, lblLogin].forEach {
            $0?.textColor = theme.primaryFontColor
        }

        // Buttons
        btnLogin.backgroundColor = theme.buttonColor
        btnLogin.setTitleColor(theme.buttonTitle, for: .normal)
        btnSignIn.tintColor = theme.buttonColor
        btnForget.setTitleColor(theme.buttonColor, for: .normal)
    }

    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: Notification.Name("themeChanged"),
            object: nil
        )
    }
}
