//
//  OrderList + delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import Foundation
import UIKit

//
//  OrderList + delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import Foundation
import UIKit
import CoreData

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as? OrderListTableViewCell else {
            return UITableViewCell()
        }

        let order = arrOrders[indexPath.row]
        guard let orderedItems = order.orderedItems as? Set<OrderedItem>, !orderedItems.isEmpty else {
                    cell.lblOrderNo.text = "Order No: \(indexPath.row + 1)"
                    cell.lblProductName.text = "Items: N/A"
                    cell.lblTotal.text = "Price: $0.00"
                    cell.imgView.image = nil
                    return cell
                }
        
        // Create an array and sort it if needed
                let orderedItemsArray = orderedItems.sorted { ($0.product?.name ?? "") < ($1.product?.name ?? "") }
                
                // The totalAmount is already fetched, so just use it
                let totalAmount = order.totalAmount
                
                // Now configure the cell with the fully loaded data
                cell.configureCell(with: orderedItemsArray, orderNumber: indexPath.row + 1)
                return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "MyOrderViewController") as? MyOrderViewController {
                // ⭐ Pass the selected Order object directly to the next view controller
                let selectedOrder = arrOrders[indexPath.row]
                detailVC.selectedOrder = selectedOrder
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
}
