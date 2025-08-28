//
//  OrderListTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import UIKit

/**
 A custom table view cell used to display information about a single order in the order list.

 This cell displays the order number, names of the products in the order, the total bill amount,
 and an image of the first product in the order.
 */
class OrderListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    /// Label to display the name(s) of the product(s) in the order
    @IBOutlet weak var lblProductName: UILabel!
    
    /// Label to display the total bill amount for the order
    @IBOutlet weak var lblTotal: UILabel!
    
    /// Label to display the order number
    @IBOutlet weak var lblOrderNo: UILabel!
    
    /// Image view to display the first product's image in the order
    @IBOutlet weak var imgView: UIImageView!
    
    // MARK: - Lifecycle Methods
    
    /// Called after the cell has been loaded from the nib file
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Called when the cell's selection state changes
    /// - Parameters:
    ///   - selected: Whether the cell is selected
    ///   - animated: Whether the change should be animated
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuration
    /**
     Configures the cell with the given ordered items and order number.
     This method sets the product names, total price, order number, and the image of the first product.
     If no image is available, a placeholder image is used.
     - Parameters:
        - orderedItems: An array of `OrderedItem` objects representing products in the order
        - orderNumber: The order number to display
     */
    func configureCell(with orderedItems: [OrderedItem], orderNumber: Int) {
        // Retrieve all product names in the order and join them as a single string
        let allProductNames = orderedItems.compactMap { $0.product?.name }.joined(separator: ", ")
        
        // Calculate the total amount for the order
        let totalAmount = orderedItems.reduce(0.0) { (result, item) -> Double in
            return result + (item.priceAtTimeOfOrder * Double(item.quantity))
        }
        
        // Set the labels with the order number, product names, and total price
        lblOrderNo.text = "Order No: \(orderNumber)"
        lblProductName.text = "Items: \(allProductNames.isEmpty ? "N/A" : allProductNames)"
        lblTotal.text = "Total Bill: $\(String(format: "%.2f", totalAmount))"
        
        // Set the image view with the first product's image or a placeholder
        if let firstProduct = orderedItems.first?.product,
           let imagePath = firstProduct.imagePath {
            imgView.image = UIImage(named: imagePath)
        } else {
            imgView.image = UIImage(named: "placeholder")
        }
        // Round the corners of the image view
        imgView.layer.cornerRadius = 10
    }
}
