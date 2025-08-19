//
//  OrderListTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import UIKit

/// `OrderListTableViewCell`
///
/// A custom table view cell for displaying order information:
/// - Shows **order number**
/// - Shows **product names**
/// - Shows **total bill amount**
/// - Shows **product image**
class OrderListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    /// Label to display product name(s).
    @IBOutlet weak var lblProductName: UILabel!
    
    /// Label to display total bill amount.
    @IBOutlet weak var lblTotal: UILabel!
    
    /// Label to display order number.
    @IBOutlet weak var lblOrderNo: UILabel!
    
    /// Image view to show first product image (or placeholder).
    @IBOutlet weak var imgView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code when the cell is loaded from nib.
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure cell selection style if needed.
    }
    
    // MARK: - Configuration
    
    /// Configures the cell with given order details.
    ///
    /// - Parameters:
    ///   - orderedItems: List of items in the order.
    ///   - orderNumber: The unique number of the order.
    ///
    /// The method:
    /// - Joins all product names into a single string.
    /// - Calculates total price for the order.
    /// - Sets order number, items, and total amount labels.
    /// - Loads first product image or sets a placeholder if unavailable.
    func configureCell(with orderedItems: [OrderedItem], orderNumber: Int) {
        
        // Get product names (joined by comma).
        let allProductNames = orderedItems
            .compactMap { $0.product?.name }
            .joined(separator: ", ")
        
        // Calculate total bill by summing up price × quantity.
        let totalAmount = orderedItems.reduce(0.0) { (result, item) -> Double in
            return result + (item.priceAtTimeOfOrder * Double(item.quantity))
        }
        
        // Set order number.
        lblOrderNo.text = "Order No: \(orderNumber)"
        
        // Show product names or N/A if empty.
        lblProductName.text = "Items: \(allProductNames.isEmpty ? "N/A" : allProductNames)"
        
        // Show formatted total bill.
        lblTotal.text = "Total Price Bill: $\(String(format: "%.2f", totalAmount))"
        
        // Load product image (first product) or placeholder.
        if let firstProduct = orderedItems.first?.product,
           let imagePath = firstProduct.imagePath {
            imgView.image = UIImage(named: imagePath)
        } else {
            imgView.image = UIImage(named: "placeholder")
        }
        
        // Round image corners.
        imgView.layer.cornerRadius = 10
    }
}
