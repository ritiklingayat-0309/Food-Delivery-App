//
//  SendOTPViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import UIKit

class SendOTPViewController: UIViewController {
    @IBOutlet weak var txtOTP1: UITextField!
    @IBOutlet weak var txtOTP4: UITextField!
    @IBOutlet weak var txtOTP3: UITextField!
    @IBOutlet weak var txtOTP2: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitile: UILabel!
    @IBOutlet weak var btnClickHer: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtOTP1.layer.cornerRadius = 12
        txtOTP2.layer.cornerRadius = 12
        txtOTP3.layer.cornerRadius = 12
        txtOTP4.layer.cornerRadius = 12
        EditStyle.setborder(textfields: [btnNext])
        let allviews = [txtOTP1!, txtOTP2!, txtOTP3!, txtOTP4!]
        for tf in allviews {
            tf.delegate = self
            tf.keyboardType = .numberPad
            tf.textAlignment = .center
        }
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        let first = txtOTP1.text ?? ""
        let Second = txtOTP2.text ?? ""
        let third = txtOTP3.text ?? ""
        let fourth = txtOTP4.text ?? ""
        
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
        

        let storyboard = UIStoryboard(name:"LoginStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "NewPasswordViewController") as? NewPasswordViewController{
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
    
    @IBAction func btnClickHereAction(_ sender: Any) {
        let alert = UIAlertController(title: "OTP Sent", message: "A new OTP has been sent to your registered mobile number.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
