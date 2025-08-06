//
//  OffersViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import UIKit

class OffersViewController: UIViewController {
    var arrOffer : [offer] = offer.getAllOffers()
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitle("Latest Offers")
        setCartButton(target: self, action: #selector(cartTapped))
        tblView.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "OffersTableViewCell")
    }

    @objc func cartTapped() {
        print("Cart tapped")
    }
}
