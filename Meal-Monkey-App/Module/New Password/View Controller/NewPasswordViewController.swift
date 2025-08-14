//
//  NewPasswordViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    @IBOutlet weak var stackConfimPass: UIStackView!
    @IBOutlet weak var stackNewPass: UIStackView!
    @IBOutlet weak var btneyeNewPass: UIButton!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var btnEyeConfirmPas: UIButton!
    @IBOutlet weak var txtCofirmPassword: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    var isPasswordVisible : Bool = false
    var isConfirmPasswordVisible : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        EditStyle.setPadding(textFields: [txtNewPassword, txtCofirmPassword], paddingWidth: 28)
        EditStyle.setborder(textfields: [btnNext])
        EditStyle.addStackBorder(stackViews: [stackConfimPass,stackNewPass]
        )
    }
    
    @IBAction func btnEyeConfirmPasAction(_ sender: Any) {
        isConfirmPasswordVisible = !isConfirmPasswordVisible
        txtCofirmPassword.isSecureTextEntry = !isConfirmPasswordVisible
        let imageName = isConfirmPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @IBAction func btnEyeNewPasswordAction(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtNewPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        
        let password = txtNewPassword.text ?? ""
        let confirmPassword = txtCofirmPassword.text ?? ""
        
        switch true {
       
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
            print("All validations passed. Continue registration.")
        }

        let storyboard = UIStoryboard(name:"FeaturesStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "FeaturesViewController") as? FeaturesViewController{
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}
