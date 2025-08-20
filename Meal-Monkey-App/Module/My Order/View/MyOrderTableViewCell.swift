//
//  MyOrderTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import UIKit

/// Custom table view cell used in `MyOrderViewController`
/// to display details of a single ordered product.
class MyOrderTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    /// Displays the quantity of the ordered product.
    @IBOutlet weak var lblQty: UILabel!
    
    /// Displays the product name.
    @IBOutlet weak var lblProductName: UILabel!
    
    /// Displays the total cost for the ordered product (`price * quantity`).
    @IBOutlet weak var lblTotal: UILabel!
    
    // MARK: - Lifecycle Methods
    
    /// Called after the cell is loaded from the nib.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Handles cell selection state changes.
    /// - Parameters:
    ///   - selected: Boolean indicating if the cell is selected.
    ///   - animated: Boolean indicating if the change should be animated.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuration
    /// Configures the cell with ordered item and its associated product.
    /// - Parameters:
    ///   - orderedItem: The `OrderedItem` object containing quantity and price info.
    ///   - product: The `Product` object containing product details.
    func configMyorder(orderedItem: OrderedItem, product: Product) {
        
        // Set product name
        lblProductName.text = product.name
        
        // Set quantity with "x"
        lblQty.text = " x \(orderedItem.quantity)"
        
        // Calculate total = price * quantity
        let total = orderedItem.priceAtTimeOfOrder * Double(orderedItem.quantity)
        
        // Display total with 2 decimal precision
        lblTotal.text = "$\(String(format: "%.2f", total))"
    }
}
