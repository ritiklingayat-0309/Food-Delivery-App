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
    @IBOutlet weak var lblCartisEmpty: UILabel!
    var pagetype : PageType = .Wishlist
    
    var itemsToShow: [ProductModel] {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        if pagetype == .Wishlist {
            return appDelegate?.arrWishlist ?? []
            
        } else { // This will handle the .Cart case and any others
            return appDelegate?.arrCart ?? []
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if pagetype == .Wishlist {
            setLeftAlignedTitleWithBack("WishList", target: self, action: #selector(backButtonTapped))
        } else {
            setLeftAlignedTitleWithBack("Cart", target: self, action: #selector(backButtonTapped))
        }
        tblView.reloadData()
        updateUI()
    }
    
    @objc func backButtonTapped()
    {
        navigationController?.popViewController(animated: true)
    }
    
    func updateUI() {
        if itemsToShow.isEmpty {
            lblCartisEmpty.isHidden = false
            lblCartisEmpty.text = (pagetype == .Wishlist) ? "Your wishlist is empty." : "Your cart is empty."
            tblView.isHidden = true
            btnPlaceOrder.isHidden = true
        } else {
            lblCartisEmpty.isHidden = true
            tblView.isHidden = false
            // Hide the Place Order button for the wishlist
            btnPlaceOrder.isHidden = (pagetype == .Wishlist)
            btnPlaceOrder.alpha = (pagetype == .Wishlist) ? 0.0 : 1.0
            tblView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "CartTableViewCell", bundle: nil ), forCellReuseIdentifier: "CartTableViewCell")
        EditStyle.setborder(textfields: [btnPlaceOrder])
        
    }
    
    @IBAction func btnPlaceOrderAction(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        if pagetype == .Wishlist {
            return // Do nothing if it's the wishlist page
        }
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
        appDelegate.saveOrders()
        appDelegate.saveCart()
        btnPlaceOrder.isHidden = true
        lblCartisEmpty.isHidden = false
        tblView.reloadData()
        let alert = UIAlertController(title: "Order Placed", message: "Your order has been placed successfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

