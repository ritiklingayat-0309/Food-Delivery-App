//
//  ProfileViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import UIKit
import CoreData

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
    
    var originalEmail: String? //  New property to store the original email
    
    var selectedImage: UIImage? //  New property to temporarily hold the selected image
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply padding and border styles to text fields and buttons
        EditStyle.setPadding(textFields: [lblName, lblEmail, lblMobile, lblAdress], paddingWidth: 28)
        EditStyle.setborder(textfields: [lblName, lblEmail, lblMobile, lblAdress, btnSave])
        
        // Add gesture recognizer for profile image tap
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(imgeTab))
        imgView.addGestureRecognizer(tabGesture)
        
        // Make profile image circular
        imgView.layer.cornerRadius = imgView.frame.size.width / 2
        imgView.layer.borderWidth = 2
        
        // Set navigation bar title and cart button
        self.setLeftAlignedTitle("Profile")
        self.setCartButton(target: self, action: #selector(cartButtonTapped))
        
        // Initially hide Save button and disable editing
        btnSave.isHidden = true
        disableEditing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserData()
    }
    
    // MARK: - Navigation Bar Actions
    
    /// Handles cart button tap and navigates to Cart screen.
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
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
        guard let savedUserIDString = UserDefaults.standard.string(forKey: "loggedInUserID"),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
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
                lblTitleUser.text = "Hi there, \(lblName.text ?? "User")!"
                
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
        KeychainHelper.save(key: "LoginStatus", value: "false")
        
        // Navigate to Login screen
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController?.pushViewController(secondVc, animated: true)
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
            UIAlertController.showAlert(title: "Error", message: "Please enter name", viewController: self)
            return
        case email.isEmpty:
            UIAlertController.showAlert(title: "Error", message: "Please enter email", viewController: self)
            return
        case !email.isValidEmail:
            UIAlertController.showAlert(title: "Invalid Email", message: "Please enter a valid email address.", viewController: self)
            return
        case mobile.isEmpty:
            UIAlertController.showAlert(title: "Error", message: "Please enter mobile number", viewController: self)
            return
        case mobile.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil:
            UIAlertController.showAlert(title: "Error", message: "Mobile number must contain only digits", viewController: self)
            return
        case mobile.count != 10:
            UIAlertController.showAlert(title: "Error", message: "Mobile number must be exactly 10 digits.", viewController: self)
            return
        case address.isEmpty:
            UIAlertController.showAlert(title: "Error", message: "Please enter address", viewController: self)
            return
        default:
            // All validations passed, proceed with saving
            break
        }
        guard let savedUserIDString = UserDefaults.standard.string(forKey: "loggedInUserID"),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let newEmail = lblEmail.text ?? ""
        let fetchRequestExistingEmail = NSFetchRequest<NSManagedObject>(entityName: "User")
        let predicateExistingEmail = NSPredicate(format: "email == %@ AND userID != %@", newEmail, savedUserIDString)
        fetchRequestExistingEmail.predicate = predicateExistingEmail
        do {
            let existingUsers = try managedContext.fetch(fetchRequestExistingEmail)
            
            if !existingUsers.isEmpty {
                // **Change 2:** If an existing user is found with the new email, show an alert
                UIAlertController.showAlert(title: "Email Already Exists", message: "This email address is already in use by another user.", viewController: self)
                lblEmail.text = originalEmail
                return
            }
        } catch {
            print("Failed to check for existing email: \(error.localizedDescription)")
            UIAlertController.showAlert(title: "Error", message: "An error occurred while validating the email.", viewController: self)
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
                                if let imageData = newImage.jpegData(compressionQuality: 1.0) {
                                    userToUpdate.setValue(imageData, forKey: "userImg")
                                }
                            }
                // Save context
                try managedContext.save()
                
                // Show success alert
                UIAlertController.showAlert(title: "Success", message: "Profile updated successfully!", viewController: self)
                loadUserData()
                // Disable editing after save
                disableEditing()
            }
        } catch {
            print("Failed to save updated user data: \(error.localizedDescription)")
            UIAlertController.showAlert(title: "Error", message: "Failed to update profile.", viewController: self)
        }
    }
}
