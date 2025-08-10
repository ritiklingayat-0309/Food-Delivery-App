//
//  PaymentDetailsViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import UIKit

class PaymentDetailsViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnAddAnotherCart: UIButton!
    @IBOutlet weak var ViewTop: UIView!
    //inside the view
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var txtCardNo: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtExpiryYear: UITextField!
    @IBOutlet weak var txtExpiryMonth: UITextField!
    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet weak var btnAddCart: UIButton!
    @IBOutlet weak var viewAddCard: UIView!
    @IBOutlet weak var viewScroll: UIView!
    var arrPayment : [PaymentModel] = PaymentModel.addcardDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "PaymentDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "PaymentDetailsTableViewCell")
        setLeftAlignedTitleWithBack("Payment Details", target: self, action: #selector(backButtonTapped))
        setCartButton(target: self, action: #selector(cartButtonTapped))
        ViewTop.isHidden = true
        viewAddCard.isHidden = true
        viewAddCard.layer.cornerRadius = 20
        viewAddCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewAddCard.layer.shadowColor = UIColor.black.cgColor
        viewAddCard.layer.shadowOpacity = 0.2
        viewAddCard.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewAddCard.layer.shadowRadius = 10
        viewScroll.layer.cornerRadius = 20
        viewScroll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewScroll.layer.shadowColor = UIColor.black.cgColor
        viewScroll.layer.shadowOpacity = 0.2
        viewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewScroll.layer.shadowRadius = 10
        EditStyle.setborder(textfields: [txtCardNo,txtSecurityCode,btnAddAnotherCart, txtFirstName,txtLastName,txtExpiryMonth,txtExpiryYear,btnAddCart])
        EditStyle.setPadding(textFields: [txtCardNo,txtSecurityCode, txtFirstName, txtLastName,txtExpiryMonth,txtExpiryYear], paddingWidth: 29)
    }
    
    @objc func cartButtonTapped() {
        print("Cart button tapped")
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddAnotherCardFromTblAction(_ sender: Any) {
        viewAddCard.isHidden = false
        ViewTop.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewAddCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    @IBAction func btnCrossAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewAddCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewAddCard.isHidden = true
            self.ViewTop.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    @IBAction func btnAddCartAction(_ sender: Any) {
    }
}
