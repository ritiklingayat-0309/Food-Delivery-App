//
//  SendOTPViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import UIKit

/// A view controller responsible for handling OTP (One Time Password) input and validation.
/// - Provides 4 text fields for OTP entry.
/// - Allows the user to request a new OTP.
/// - Navigates to the "New Password" screen upon successful OTP entry.
class SendOTPViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    /// First digit OTP text field
    @IBOutlet weak var txtOTP1: UITextField!
    
    /// Fourth digit OTP text field
    @IBOutlet weak var txtOTP4: UITextField!
    
    /// Third digit OTP text field
    @IBOutlet weak var txtOTP3: UITextField!
    
    /// Second digit OTP text field
    @IBOutlet weak var txtOTP2: UITextField!
    
    /// Title label (e.g., "Verify OTP")
    @IBOutlet weak var lblTitle: UILabel!
    
    /// Subtitle label (e.g., "Enter the OTP sent to your mobile number")
    @IBOutlet weak var lblSubtitile: UILabel!
    
    /// Button to resend OTP ("Click Here")
    @IBOutlet weak var btnClickHer: UIButton!
    
    /// Button to proceed to next step ("Next")
    @IBOutlet weak var btnNext: UIButton!
    
    
    // MARK: - Lifecycle Methods
    
    /// Called after the controller’s view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply corner radius to OTP text fields
        txtOTP1.layer.cornerRadius = 12
        txtOTP2.layer.cornerRadius = 12
        txtOTP3.layer.cornerRadius = 12
        txtOTP4.layer.cornerRadius = 12
        
        // Apply border style to the "Next" button
        EditStyle.setborder(textfields: [btnNext])
        
        // Configure all OTP text fields
        let allviews = [txtOTP1!, txtOTP2!, txtOTP3!, txtOTP4!]
        for tf in allviews {
            tf.delegate = self
            tf.keyboardType = .numberPad
            tf.textAlignment = .center
        }
        
        // Hide back button from navigation bar
        self.navigationItem.hidesBackButton = true
    }
    
    
    // MARK: - IBActions
    
    /// Action triggered when "Next" button is tapped.
    /// - Validates OTP fields and shows an alert if any digit is missing.
    /// - Navigates to `NewPasswordViewController` upon successful OTP entry.
    @IBAction func btnNextAction(_ sender: Any) {
        let first = txtOTP1.text ?? ""
        let Second = txtOTP2.text ?? ""
        let third = txtOTP3.text ?? ""
        let fourth = txtOTP4.text ?? ""
        
        // Validate OTP input
        switch true {
        case first.isEmpty:
            UIAlertController.showAlert(
                title: "Error",
                message: "Please enter OTP",
                viewController: self
            )
       
        case Second.isEmpty:
            UIAlertController.showAlert(
                title: "Error",
                message: "Please enter OTP",
                viewController: self
            )
            
        case third.isEmpty:
            UIAlertController.showAlert(
                title: "Error",
                message: "Please enter OTP",
                viewController: self
            )
            
        case fourth.isEmpty:
            UIAlertController.showAlert(
                title: "Error",
                message: "Please enter OTP",
                viewController: self
            )
            
        default:
            print("Valid OTP entered.")
        }
        
        // Navigate to NewPasswordViewController
        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "NewPasswordViewController") as? NewPasswordViewController {
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
    
    /// Action triggered when "Click Here" button is tapped.
    /// - Displays an alert that a new OTP has been sent.
    @IBAction func btnClickHereAction(_ sender: Any) {
        let alert = UIAlertController(
            title: "OTP Sent",
            message: "A new OTP has been sent to your registered mobile number.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
