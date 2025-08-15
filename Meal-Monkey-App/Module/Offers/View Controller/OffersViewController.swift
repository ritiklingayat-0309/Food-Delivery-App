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
        tblView.showsVerticalScrollIndicator = false
        setLeftAlignedTitle("Latest Offers")
        setCartButton(target: self, action: #selector(cartTapped))
        tblView.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "OffersTableViewCell")
        btnCheckOffer.layer.cornerRadius = btnCheckOffer.frame.height/2
    }
    
    @objc func cartTapped() {
        print("Cart tapped")
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            secondVC.pagetype = .Cart
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    @IBAction func btnCheckOfferAction(_ sender: Any) {
    }
}


