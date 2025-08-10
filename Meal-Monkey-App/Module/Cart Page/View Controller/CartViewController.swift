//
//  CartViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 10/08/25.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    // The cartItems will be a computed property that reads directly from the AppDelegate.
        var cartItems: [ProductModel] {
            return (UIApplication.shared.delegate as? AppDelegate)?.arrCart ?? []
        }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          // Reload the data every time the view appears to get the latest cart items.
          tblView.reloadData()
      }
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "CartTableViewCell", bundle: nil ), forCellReuseIdentifier: "CartTableViewCell")
    }

    @IBAction func btnPlaceOrderAction(_ sender: Any) {
    }
    
}
