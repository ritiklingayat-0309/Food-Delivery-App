//
//  OrderListViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import UIKit

class OrderListViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    var orders : [[ProductModel]] {
        return (UIApplication.shared.delegate as? AppDelegate)?.arrOrder ?? []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Order List"
        tblView.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
    }
}


