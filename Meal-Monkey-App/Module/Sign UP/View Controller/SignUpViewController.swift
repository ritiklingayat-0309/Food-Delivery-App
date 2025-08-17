//
//  SignUpViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 01/08/25.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnAlreadyHaveAccount: UIButton!
    @IBOutlet weak var stackPasswordeye: UIStackView!
    @IBOutlet weak var stackConfirmPaseye: UIStackView!
    var isPasswordVisible : Bool = false
    var isConfirmPasswordVisible : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        EditStyle.setPadding(textFields: [txtName, txtMobileNo,txtEmail,txtAddress,txtPassword,txtConfirmPassword], paddingWidth: 28)
        EditStyle.setborder(textfields: [txtName, txtMobileNo, txtEmail,txtAddress,btnSignUp])
        EditStyle.addStackBorder(stackViews: [stackPasswordeye,stackConfirmPaseye])
    }
    
    @IBAction func btnPasswordEyeAction(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @IBAction func btnConfirPassEyeAction(_ sender: Any) {
        isConfirmPasswordVisible = !isConfirmPasswordVisible
        txtConfirmPassword.isSecureTextEntry = !isConfirmPasswordVisible
        let imageName = isConfirmPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @IBAction func btnAlreadyAcountLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if ((storyboard.instantiateViewController(withIdentifier : "LoginViewController") as? LoginViewController) != nil){
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnSignUpAction(_ sender: Any) {
        let name = txtName.text ?? ""
        let email = txtEmail.text ?? ""
        let mobile = txtMobileNo.text ?? ""
        let address = txtAddress.text ?? ""
        let password = txtPassword.text ?? ""
        let confirmPassword = txtConfirmPassword.text ?? ""
        
        switch true {
        case name.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter name",
                                        viewController: self)
            
        case email.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter email",
                                        viewController: self)
            
        case !email.isValidEmail:
            UIAlertController.showAlert(title: "Invalid Email",
                                        message: "Please enter a valid email address.",
                                        viewController: self)
            
        case mobile.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter mobile number",
                                        viewController: self)
            
        case mobile.count != 10:
            UIAlertController.showAlert(title: "Error",
                                        message: "Mobile number must be exactly 10 digits.",
                                        viewController: self)
            
        case address.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter address",
                                        viewController: self)
            
        case password.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter password",
                                        viewController: self)
            
        case !password.isValidPassword:
            UIAlertController.showAlert(title: "Invalid Password",
                                        message: "Please enter a valid password.",
                                        viewController: self)
            
        case confirmPassword.isEmpty:
            UIAlertController.showAlert(title: "Error",
                                        message: "Please enter confirm password",
                                        viewController: self)
            
        case password != confirmPassword:
            UIAlertController.showAlert(title: "Error",
                                        message: "Confirm password does not match",
                                        viewController: self)
            
        default:
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            guard let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext) else { return }
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(name, forKey: "name")
            user.setValue(email, forKey: "email")
            user.setValue(mobile, forKey: "mobileNo")
            user.setValue(address, forKey: "address")
            user.setValue(password, forKey: "password")
            user.setValue(UUID(), forKey: "userID")
            
            do {
                try managedContext.save()
                print("✅ User saved successfully!")
                
                // Now, call the function (which is outside this method)
                self.fetchAllUsersFromCoreData()
                
                UIAlertController.showAlert(title: "Success",
                                            message: "Registration successful! You can now log in.",
                                            viewController: self){
                    self.navigationController?.popViewController(animated: true)
                }
            } catch let error as NSError {
                print("❌ Could not save user. \(error), \(error.userInfo)")
                
                UIAlertController.showAlert(title: "Error",
                                            message: "Registration failed. Please try again.",
                                            viewController: self)
                
            }
        }
    }
    
    func fetchAllUsersFromCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            let users = try context.fetch(fetchRequest)
            print("--- 📄 Fetched Users ---")
            print("Total users found: \(users.count)")
            for (index, user) in users.enumerated() {
                let username = user.value(forKey: "name") as? String ?? "No Name"
                let userEmail = user.value(forKey: "email") as? String ?? "No Email"
                let userID = (user.value(forKey: "userID") as? UUID)?.uuidString ?? "No ID"
                let userPass = (user.value(forKey: "password") as? String ?? "No Password")
                print("--- User \(index + 1) ---")
                print("Name: \(username)")
                print("Email: \(userEmail)")
                print("UserID: \(userID)")
                print("password: \(userPass)")
            }
            print("-------------------------")
        } catch {
            print("❌ Failed to fetch users: \(error.localizedDescription)")
        }
    }
}
