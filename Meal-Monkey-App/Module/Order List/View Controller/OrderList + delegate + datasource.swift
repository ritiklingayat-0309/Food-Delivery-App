//
//  OrderList + delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import Foundation
import UIKit

extension OrderListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : OrderListTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        let order  = orders[indexPath.row]
        cell.configureCell(with: order, orderNumber: indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "MyOrderViewController") as? MyOrderViewController {
                detailVC.orderProducts = orders[indexPath.row] 
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        
    }
}
