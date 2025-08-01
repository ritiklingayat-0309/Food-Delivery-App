//
//  ResetPasswordViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 01/08/25.
//

import UIKit

class ResetPasswordViewController: UIViewController {


    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var btnSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        txtEmail.setPadding(left: 20,right: 20)
        txtEmail.design()
        btnSend.design()
    }
    

}
