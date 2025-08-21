//
//  Payment + Delegate + Datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import Foundation
import UIKit

/// Extension of `PaymentDetailsViewController`
/// Implements `UITableViewDelegate` and `UITableViewDataSource`
/// to manage payment cards list in the table view.
extension PaymentDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Returns the number of rows (cards) in the section.
    /// - Parameters:
    ///   - tableView: The table view requesting this information.
    ///   - section: The section index (always `0` in this case).
    /// - Returns: The total number of payment cards in `arrsharedPaymentCards`.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentDetails.count
    }
    
    /// Provides a cell to display a payment card at a specific index.
    /// - Parameters:
    ///   - tableView: The table view requesting the cell.
    ///   - indexPath: The index path specifying the row.
    /// - Returns: A configured `PaymentDetailsTableViewCell`.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue reusable cell of type `PaymentDetailsTableViewCell`
        let cell: PaymentDetailsTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "PaymentDetailsTableViewCell",
            for: indexPath
        ) as! PaymentDetailsTableViewCell
        
        // Assign delegate to handle delete button actions
        cell.delegate = self
        
        // Get card details from shared array
        let cardDetail = paymentDetails[indexPath.row]
        
        // If card number exists, configure the cell
        // **Change:** Configure the cell with the card number from the Core Data object
                cell.configure(with: String(cardDetail.cardNumber))
                return cell
    }
}
