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
    
    var cartItems: [ProductModel] {
        return (UIApplication.shared.delegate as? AppDelegate)?.arrCart ?? []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblView.reloadData()
        EditStyle.setborder(textfields: [btnPlaceOrder])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "CartTableViewCell", bundle: nil ), forCellReuseIdentifier: "CartTableViewCell")
        self.title = "Cart"
    }
    
    @IBAction func btnPlaceOrderAction(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        if appDelegate.arrCart.isEmpty {
            let alert = UIAlertController(title: "Empty Cart", message: "Please add items before placing an order.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        if !appDelegate.arrCart.isEmpty {
            appDelegate.arrOrder.append(appDelegate.arrCart)
            appDelegate.arrCart.removeAll()
        }
    
        tblView.reloadData()
        
        // Show alert
        let alert = UIAlertController(title: "Order Placed", message: "Your order has been placed successfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
}

