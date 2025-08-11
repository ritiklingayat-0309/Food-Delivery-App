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
        let storyboard = UIStoryboard(name:"MoreStoryboard", bundle : nil)
        if let secondVc = storyboard.instantiateViewController(withIdentifier : "CheckOutViewController") as? CheckOutViewController{
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}
