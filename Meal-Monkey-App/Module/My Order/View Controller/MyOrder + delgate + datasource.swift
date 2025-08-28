//
//  MyOrder + delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import Foundation
import UIKit

/// Extension of `MyOrderViewController` to handle `UITableView`
/// delegate and data source methods for displaying ordered items.
extension MyOrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    /// Returns the number of rows (ordered items) in the section.
    /// - Parameters:
    ///   - tableView: The table view requesting this information.
    ///   - section: The index of the section (only one section here).
    /// - Returns: Count of `orderedItems`.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedItems.count
    }
    
    /// Configures and returns the cell for a given row.
    /// - Parameters:
    ///   - tableView: The table view requesting the cell.
    ///   - indexPath: The index path locating the row in the table view.
    /// - Returns: A configured `MyOrderTableViewCell` instance.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue reusable cell of type `MyOrderTableViewCell`
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTableViewCell",
                                                 for: indexPath) as! MyOrderTableViewCell
        
        // Get the ordered item for the current row
        let orderedItem = orderedItems[indexPath.row]
        
        // Configure the cell with ordered item and its associated product
        if let product = orderedItem.product {
            cell.configMyorder(orderedItem: orderedItem, product: product)
        }
        return cell
    }
}
