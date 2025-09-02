//
//  SendOTPViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import UIKit
import DPOTPView
/// A view controller responsible for handling OTP (One Time Password) input and validation.
/// - Provides 4 text fields for OTP entry.
/// - Allows the user to request a new OTP.
/// - Navigates to the "New Password" screen upon successful OTP entry.
class SendOTPViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    
    @IBOutlet weak var otpView: DPOTPView!
    
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
        
        otpView.count = 4
        otpView.spacing = 10
        otpView.fontTextField = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(25.0))!
        otpView.dismissOnLastEntry = true
        otpView.borderColorTextField = .black
        otpView.selectedBorderColorTextField = .blue
        otpView.borderWidthTextField = 2
        otpView.backGroundColorTextField = .lightGray
        otpView.cornerRadiusTextField = 8
        otpView.isCursorHidden = true
        //txtOTPView.isSecureTextEntry = true
        //txtOTPView.isBottomLineTextField = true
        //txtOTPView.isCircleTextField = true
        view.addSubview(otpView)
        
        // Apply border style to the "Next" button
        EditStyle.setborder(textfields: [btnNext])
        
        // Hide back button from navigation bar
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - IBActions
    /// Action triggered when "Next" button is tapped.
    /// - Validates OTP fields and shows an alert if any digit is missing.
    /// - Navigates to `NewPasswordViewController` upon successful OTP entry.
    @IBAction func btnNextAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.StoryboardIdentifier.LoginStoryboard, bundle: nil)
        if let seondVc = storyboard.instantiateViewController(withIdentifier: Main.ViewControllerIdentifier.NewPasswordViewController) as? NewPasswordViewController {
            self.navigationController?.pushViewController(seondVc, animated: true)
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
