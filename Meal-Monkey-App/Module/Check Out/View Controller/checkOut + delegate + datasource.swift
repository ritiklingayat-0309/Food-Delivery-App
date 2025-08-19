//
//  checkOut + delegate + datasource.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import Foundation
import UIKit

// MARK: - UITableView Delegate & DataSource

/// Extension to manage table view delegate and data source methods for `CheckOutViewController`.
extension CheckOutViewController : UITableViewDelegate, UITableViewDataSource {
    
    /// Returns the number of rows in the table view
    /// Includes shared payment cards plus Cash on Delivery and Gmail options
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrsharedPaymentCards.count + 2
    }
    
    /// Configures and returns the cell for a given index path
    /// - Parameter indexPath: IndexPath of the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        // Cash on Delivery cell
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CashOnDeliveryTableViewCell", for: indexPath) as! CashOnDeliveryTableViewCell
            cell.btnSelect.isSelected = (selectedPaymentIndex == 0)
            return cell
            
        // Visa / Card cells
        case 1..<1 + arrsharedPaymentCards.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VisaTableViewCell", for: indexPath) as! VisaTableViewCell
            let cardIndex = indexPath.row - 1
            if cardIndex < arrsharedPaymentCards.count {
                let cardDetails = arrsharedPaymentCards[cardIndex]
                if let fullCardNumber = cardDetails["cardNo"] {
                    let lastFourDigits = String(fullCardNumber.suffix(4))
                    cell.lblCardNo.text = "**** **** **** \(lastFourDigits)"
                }
            }
            cell.btnSelect.isSelected = (selectedPaymentIndex == indexPath.row)
            return cell
            
        // Gmail payment option cell
        case 1 + arrsharedPaymentCards.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GmailTableViewCell", for: indexPath) as! GmailTableViewCell
            cell.btncircle.isSelected = (selectedPaymentIndex == indexPath.row)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    /// Handles selection of a table view row
    /// Updates the selected payment method index and reloads the table
    /// - Parameter indexPath: IndexPath of the selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPaymentIndex = indexPath.row
        tblView.reloadData()
    }
}

// MARK: - UITextField Delegate

/// Extension to handle keyboard return key navigation between text fields
extension CheckOutViewController : UITextFieldDelegate {
    
    /// Handles the Return key press for text fields
    /// Moves focus to the next text field or dismisses keyboard
    /// - Parameter textField: Current active UITextField
    /// - Returns: Bool indicating if the action was handled
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtCardNo:
            txtExpMonth.becomeFirstResponder()
        case txtExpMonth:
            txtExpYear.becomeFirstResponder()
        case txtExpYear:
            txtSecurityCode.becomeFirstResponder()
        case txtSecurityCode:
            txtFirstName.becomeFirstResponder()
        case txtFirstName:
            txtLastName.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
