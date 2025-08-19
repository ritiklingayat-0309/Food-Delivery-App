//
//  Offer Delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import Foundation
import UIKit

/// Extension of `OffersViewController` to handle `UITableViewDelegate` and `UITableViewDataSource`.
///
/// This manages:
/// - Displaying the list of offers in a table view.
/// - Providing the data (number of rows, cell configuration).
extension OffersViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView DataSource
    
    /// Returns the number of rows in the table view.
    ///
    /// - Parameters:
    ///   - tableView: The table view requesting the information.
    ///   - section: The section index (only one section used here).
    /// - Returns: Number of offers available in `arrOffer`.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOffer.count
    }
    
    /// Configures and returns a cell for the given row at the specified index path.
    ///
    /// - Parameters:
    ///   - tableView: The table view requesting the cell.
    ///   - indexPath: The index path specifying the row.
    /// - Returns: A configured `OffersTableViewCell`.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue a reusable cell of type `OffersTableViewCell`.
        let cell: OffersTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "OffersTableViewCell",
            for: indexPath
        ) as! OffersTableViewCell
        // Configure cell with the corresponding offer data.
        cell.configOffer(offer: arrOffer[indexPath.row])
        return cell
    }
}
