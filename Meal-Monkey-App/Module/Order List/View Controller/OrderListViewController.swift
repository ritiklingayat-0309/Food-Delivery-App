//
//  OrderListViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import UIKit

class OrderListViewController: UIViewController {
    
    @IBOutlet weak var lblOrderListEmpt: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var orders : [[ProductModel]] {
        return (UIApplication.shared.delegate as? AppDelegate)?.arrOrder ?? []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Order List"
        tblView.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
        tblView.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func updateUI() {
        if orders.isEmpty {
            lblOrderListEmpt.isHidden = false
            tblView.isHidden = true
        } else {
            lblOrderListEmpt.isHidden = true
            tblView.isHidden = false
            tblView.reloadData()
        }
    }
}


