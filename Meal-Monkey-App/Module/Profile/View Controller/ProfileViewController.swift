//
//  ProfileViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var lblTitleUser: UILabel!
    @IBOutlet weak var lblName: UITextField!
    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblMobile: UITextField!
    @IBOutlet weak var lblAdress: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStyle(textfield: [lblName,lblEmail,lblMobile,lblAdress,btnSave])
        setPadding(textfield: [ lblName,lblEmail,lblMobile,lblAdress])
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(imgeTab))
        imgView.addGestureRecognizer(tabGesture)
        imgView.layer.cornerRadius = 50
        self.setLeftAlignedTitle("Profile")
        self.setCartButton(target: self, action: #selector(cartButtonTapped))
    }
    
    @objc func cartButtonTapped() {
        print("Cart button tapped")
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
    
    @objc func imgeTab() {
        print("click on image")
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
    
    @IBAction func btnEditProfileAction(_ sender: Any) {
    }
    
    @IBAction func btnSignOutAction(_ sender: Any) {
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
    }
}
