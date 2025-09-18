//
//  ProfileViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import CoreData
import UIKit

/// Controller responsible for displaying and editing the user profile.
/// - Shows user information (name, email, mobile, address).
/// - Supports editing/saving profile data.
/// - Handles profile image update.
/// - Manages sign-out and navigation to the login screen.
class ProfileViewController: UIViewController {
    // MARK: - Outlets
    /// Profile image view (user avatar).
    @IBOutlet weak var imgView: UIImageView!
    /// Edit Profile button (enables editing mode).
    @IBOutlet weak var btnEditProfile: UIButton!
    /// Sign Out button (logs out the user).
    @IBOutlet weak var btnSignOut: UIButton!
    /// Label for greeting the user.
    @IBOutlet weak var lblTitleUser: UILabel!
    /// Text field for name.
    @IBOutlet weak var lblName: UITextField!
    /// Text field for email.
    @IBOutlet weak var lblEmail: UITextField!
    /// Text field for mobile number.
    @IBOutlet weak var lblMobile: UITextField!
    /// Text field for address.
    @IBOutlet weak var lblAdress: UITextField!
    /// Save button (saves updated profile).
    @IBOutlet weak var btnSave: UIButton!

    var originalEmail: String?  //  New property to store the original email

    var selectedImage: UIImage?  //  New property to temporarily hold the selected image

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Apply padding and border styles to text fields and buttons
        EditStyle.setPadding(
            textFields: [lblName, lblEmail, lblMobile, lblAdress],
            paddingWidth: 28
        )
        EditStyle.setborder(textfields: [
            lblName, lblEmail, lblMobile, lblAdress, btnSave,
        ])

        // Add gesture recognizer for profile image tap
        let tabGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(imgeTab)
        )
        imgView.addGestureRecognizer(tabGesture)

        // Make profile image circular
        imgView.layer.cornerRadius = imgView.frame.size.width / 2
        imgView.layer.borderWidth = 2

        self.setCartButton(target: self, action: #selector(cartButtonTapped))

        // Initially hide Save button and disable editing
        btnSave.isHidden = true
        disableEditing()

        // Listen for language change notification
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(languageChanged),
            name: .languageChanged,
            object: nil
        )
        //Refresh UI for current language
        languageChanged()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: Notification.Name("themeChanged"),
            object: nil
        )
        applyTheme()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserData()
        languageChanged()
    }

    @objc private func languageChanged() {
        // Update navigation title
        setLeftAlignedTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.Profile.navProfile
            )
        )

        // Update placeholders
        lblName.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.Profile.namePlc
        )
        lblEmail.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.Profile.emailPlc
        )
        lblMobile.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.Profile.mobilePlc
        )
        lblAdress.placeholder = LocalizationManager.shared.localizedString(
            forKey: Main.Profile.addressPlc
        )

        // Update buttons
        btnEditProfile.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.Profile.btnEditPro
            ),
            for: .normal
        )
        btnSave.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.Profile.btnSave
            ),
            for: .normal
        )
        btnSignOut.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.Profile.btnSignOut
            ),
            for: .normal
        )

        // Update user greeting
        let userName = lblName.text?.isEmpty == false ? lblName.text! : "User"
        lblTitleUser.text = String(
            format: LocalizationManager.shared.localizedString(
                forKey: Main.Profile.greeting
            ),
            userName
        )
    }

    // MARK: - Navigation Bar Actions

    /// Handles cart button tap and navigates to Cart screen.
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

    // MARK: - Profile Image

    /// Handles tap on profile image and opens image picker.
    @objc func imgeTab() {
        print("click on image")
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }

    // MARK: - Load User Data
    /// Loads user profile data from Core Data based on logged-in user ID.
    func loadUserData() {
        guard
            let savedUserIDString = UserDefaults.standard.string(
                forKey: "loggedInUserID"
            ),
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        let predicate = NSPredicate(format: "userID == %@", savedUserIDString)
        fetchRequest.predicate = predicate

        do {
            let users = try managedContext.fetch(fetchRequest)
            if let user = users.first {
                lblName.text = user.value(forKey: "name") as? String
                lblEmail.text = user.value(forKey: "email") as? String
                lblMobile.text = user.value(forKey: "mobileNo") as? String
                lblAdress.text = user.value(forKey: "address") as? String
                //                lblTitleUser.text = "Hi there, \(lblName.text ?? "User")!"

                // **Change:** Store the original email to revert later if needed
                self.originalEmail = user.value(forKey: "email") as? String
                // **Change:** Load and display the user image from Core Data
                if let imageData = user.value(forKey: "userImg") as? Data {
                    imgView.image = UIImage(data: imageData)
                }
            }
        } catch {
            print("Failed to fetch user data: \(error.localizedDescription)")
        }
    }

    // MARK: - Editing Profile

    /// Enables editing mode for profile fields.
    private func enableEditing() {
        lblName.isEnabled = true
        lblEmail.isEnabled = true
        lblMobile.isEnabled = true
        lblAdress.isEnabled = true
        btnSave.isHidden = false
        btnEditProfile.isHidden = true
    }

    /// Disables editing mode for profile fields.
    private func disableEditing() {
        lblName.isEnabled = false
        lblEmail.isEnabled = false
        lblMobile.isEnabled = false
        lblAdress.isEnabled = false
        btnSave.isHidden = true
        btnEditProfile.isHidden = false
    }

    // MARK: - Actions

    /// Edit Profile button tapped → enables editing.
    @IBAction func btnEditProfileAction(_ sender: Any) {
        enableEditing()
    }

    /// Sign Out button tapped → clears session and navigates to login screen.
    @IBAction func btnSignOutAction(_ sender: Any) {
        // Remove saved user session
        UserDefaults.standard.removeObject(forKey: "loggedInUserID")

        // Navigate to Login screen
        let storyboard = UIStoryboard(
            name: Main.StoryboardIdentifier.LoginStoryboard,
            bundle: nil
        )
        if let secondVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllerIdentifier.LoginViewController
        ) as? LoginViewController {
            self.navigationController?.pushViewController(
                secondVc,
                animated: true
            )
        }
    }

    /// Save button tapped → updates user profile in Core Data.
    @IBAction func btnSaveAction(_ sender: Any) {
        // **Change:** Retrieve values
        let name = lblName.text ?? ""
        let email = lblEmail.text ?? ""
        let mobile = lblMobile.text ?? ""
        let address = lblAdress.text ?? ""

        // **Change:** Use a switch statement for validation
        switch true {
        case name.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterName
            )
            return

        case email.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterEmail
            )
            return

        case !email.isValidEmail:
            showAlert(
                titleKey: Main.AlertTitle.invalidEmail,
                messageKey: Main.AlertMessage.invalidEmail
            )
            return

        case mobile.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterMobile
            )
            return

        case mobile.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted)
            != nil:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.digitsOnly
            )
            return

        case mobile.count != 10:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.mobileLength
            )
            return

        case address.isEmpty:
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.enterAddress
            )
            return

        default:
            // All validations passed, proceed with saving
            break
        }
        guard
            let savedUserIDString = UserDefaults.standard.string(
                forKey: "loggedInUserID"
            ),
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let newEmail = lblEmail.text ?? ""
        let fetchRequestExistingEmail = NSFetchRequest<NSManagedObject>(
            entityName: "User"
        )
        let predicateExistingEmail = NSPredicate(
            format: "email == %@ AND userID != %@",
            newEmail,
            savedUserIDString
        )
        fetchRequestExistingEmail.predicate = predicateExistingEmail
        do {
            let existingUsers = try managedContext.fetch(
                fetchRequestExistingEmail
            )

            if !existingUsers.isEmpty {
                // **Change 2:** If an existing user is found with the new email, show an alert
                showAlert(
                    titleKey: "email_exists_title_03",
                    messageKey: "email_exists_msg_03"
                )
                lblEmail.text = originalEmail
                return
            }
        } catch {
            print(
                "Failed to check for existing email: \(error.localizedDescription)"
            )
            UIAlertController.showAlert(
                title: "Error",
                message: "An error occurred while validating the email.",
                viewController: self
            )
            return
        }

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        let predicate = NSPredicate(format: "userID == %@", savedUserIDString)
        fetchRequest.predicate = predicate

        do {
            let users = try managedContext.fetch(fetchRequest)
            if let userToUpdate = users.first {
                // Update values
                userToUpdate.setValue(lblName.text, forKey: "name")
                userToUpdate.setValue(lblEmail.text, forKey: "email")
                userToUpdate.setValue(lblMobile.text, forKey: "mobileNo")
                userToUpdate.setValue(lblAdress.text, forKey: "address")
                // **Change:** Save the new image to Core Data if a new one was selected
                if let newImage = self.selectedImage {
                    if let imageData = newImage.jpegData(
                        compressionQuality: 1.0
                    ) {
                        userToUpdate.setValue(imageData, forKey: "userImg")
                    }
                }
                // Save context
                try managedContext.save()

                // Show success alert
                showAlert(
                    titleKey: Main.AlertTitle.success,
                    messageKey: Main.AlertMessage.profileUpdate
                )
                loadUserData()
                // Disable editing after save
                disableEditing()
            }
        } catch {
            print(
                "Failed to save updated user data: \(error.localizedDescription)"
            )
            showAlert(
                titleKey: Main.AlertTitle.error,
                messageKey: Main.AlertMessage.profileUpdateError
            )
        }
    }

    @objc func applyTheme() {
        let theme = ThemeManager.currentTheme

        // Background
        imgView.layer.borderColor = theme.buttonColor.cgColor

        // Labels
        lblTitleUser.textColor = theme.labelColor

        // Buttons
        let buttons = [btnSave]
        buttons.forEach { btn in
            btn?.backgroundColor = theme.buttonColor
            btn?.setTitleColor(.white, for: .normal)
            btn?.clipsToBounds = true
        }

        let labelBtn = [btnSignOut, btnEditProfile]
        labelBtn.forEach { btn in
            btn?.setTitleColor(theme.buttonColor, for: .normal)
        }
        // TextFields
        let textFields = [lblName, lblEmail, lblMobile, lblAdress]
        textFields.forEach { field in
            field?.textColor = theme.primaryFontColor
            field?.backgroundColor = theme.cellBackgroundColor
            field?.layer.cornerRadius = 28  // same as styleViews
            field?.layer.borderWidth = 1
            field?.layer.borderColor = UIColor.black.cgColor
            field?.clipsToBounds = true
            if let placeholder = field?.placeholder {
                field?.attributedPlaceholder = NSAttributedString(
                    string: placeholder,
                    attributes: [
                        NSAttributedString.Key.foregroundColor: theme
                            .placeholderColor
                    ]
                )
            }
        }

        // Navigation bar
        navigationController?.navigationBar.barTintColor = theme.mainColor
        navigationController?.navigationBar.tintColor = theme.accentColor
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: theme.primaryFontColor
        ]
    }

    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: Notification.Name("themeChanged"),
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: .languageChanged,
            object: nil
        )
    }
}
