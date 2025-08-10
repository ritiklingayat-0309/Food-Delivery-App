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
        EditStyle.setPadding(textFields: [txtEmail, txtCofirmPassword], paddingWidth: 28)
        EditStyle.setborder(textfields: [txtEmail, txtCofirmPassword, btnNext])
    }
    @IBAction func btnNextAction(_ sender: Any) {
        let storyboard = UIStoryboard(name:"FeaturesStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "FeaturesViewController") as? FeaturesViewController{
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}
