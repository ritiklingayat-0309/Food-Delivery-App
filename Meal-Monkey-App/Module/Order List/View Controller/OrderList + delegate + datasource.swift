//
//  OrderList + delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import Foundation
import UIKit
import CoreData

/**
 Extension for `OrderListViewController` to conform to `UITableViewDelegate` and `UITableViewDataSource`.
 This extension handles displaying the list of orders in a table view, configuring cells, and
 navigating to order details when a row is selected.
 */
extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource Methods
    
    /**
     Returns the number of rows in the table view based on the number of orders.
     - Parameters:
     - tableView: The UITableView requesting this information
     - section: Section index
     - Returns: Number of orders in the list
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOrders.count
    }
    
    /**
     Returns the cell for a given index path.
     Configures the cell with order details including order number, product names, total price, and first product image.
     - Parameters:
     - tableView: The UITableView requesting the cell
     - indexPath: IndexPath of the cell
     - Returns: Configured `OrderListTableViewCell`
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as? OrderListTableViewCell else {
            return UITableViewCell()
        }
        // Calculate the index for the reversed order
        let reversedIndex = arrOrders.count - 1 - indexPath.row
        
        // Get the order object using the reversed index
        let order = arrOrders[reversedIndex]
        
        // ⭐ FIX: Force Core Data to resolve the relationships for all items
        guard let orderedItems = order.orderedItems as? Set<OrderedItem>, !orderedItems.isEmpty else {
            // Display default values if no ordered items are found
            cell.lblOrderNo.text = "Order No: \(indexPath.row + 1)"
            cell.lblProductName.text = "Items: N/A"
            cell.lblTotal.text = "Price: $0.00"
            cell.imgView.image = nil
            return cell
        }
        
        // Convert set to array and sort items alphabetically by product name
        let orderedItemsArray = orderedItems.sorted { ($0.product?.name ?? "") < ($1.product?.name ?? "") }
        
        // Use the already calculated total amount from Core Data
        let totalAmount = order.totalAmount
        let orderNumber = reversedIndex + 1
        
        // Configure the cell with the fully loaded data
        cell.configureCell(with: orderedItemsArray, orderNumber: orderNumber)
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    /**
     Handles the event when a row is selected in the table view.
     Navigates to the `MyOrderViewController` to show detailed information for the selected order.
     
     - Parameters:
     - tableView: The UITableView where the selection occurred
     - indexPath: IndexPath of the selected row
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "MyOrderViewController") as? MyOrderViewController {
            let reversedIndex = arrOrders.count - 1 - indexPath.row
            let selectedOrder = arrOrders[reversedIndex]
            detailVC.selectedOrder = selectedOrder
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
