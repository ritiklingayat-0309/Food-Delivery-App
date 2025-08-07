//
//  OffersViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import UIKit

class OffersViewController: UIViewController {
    var arrOffer : [offer] = offer.getAllOffers()
    @IBOutlet weak var btnCheckOffer: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitle("Latest Offers")
        setCartButton(target: self, action: #selector(cartTapped))
        tblView.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "OffersTableViewCell")
        viewStyle(textfield: [btnCheckOffer])
        setPadding(textfield: [])
    }
    
    func viewStyle(textfield: [UIView]){
        for item in textfield {
            item.viewStyle(cornerRadius: btnCheckOffer.frame.height/2, borderWidth: 0, borderColor: .systemGray)
        }
    }
    
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @objc func cartTapped() {
        print("Cart tapped")
    }
    
    @IBAction func btnCheckOfferAction(_ sender: Any) {
    }
    
    
    
    
    
}


