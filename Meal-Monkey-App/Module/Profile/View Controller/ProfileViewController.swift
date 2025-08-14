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
        EditStyle.setPadding(textFields: [lblName,lblEmail,lblMobile,lblAdress], paddingWidth: 28)
        EditStyle.setborder(textfields: [lblName,lblEmail,lblMobile,lblAdress,btnSave])
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(imgeTab))
        imgView.addGestureRecognizer(tabGesture)
        imgView.layer.cornerRadius = imgView.frame.height/2
        self.setLeftAlignedTitle("Profile")
        self.setCartButton(target: self, action: #selector(cartButtonTapped))
    }
    
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            navigationController?.pushViewController(secondVC, animated: true)
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
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
    }
}
