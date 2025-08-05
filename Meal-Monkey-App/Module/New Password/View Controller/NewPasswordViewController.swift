//
//  NewPasswordViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

class NewPasswordViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCofirmPassword: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        viewStyle(textfield: [txtEmail, txtCofirmPassword, btnNext])
        setPadding(textfield: [txtEmail, txtCofirmPassword])
    }
    func viewStyle(textfield: [UIView]){
        for item in textfield {
            item.viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray)
        }
    }

    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        let storyboard = UIStoryboard(name:"FeaturesStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "FeaturesViewController") as? FeaturesViewController{
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}
