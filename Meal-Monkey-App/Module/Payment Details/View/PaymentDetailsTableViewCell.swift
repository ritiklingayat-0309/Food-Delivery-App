//
//  PaymentDetailsTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import UIKit

/// A protocol to notify when the delete button is tapped inside `PaymentDetailsTableViewCell`.
protocol PaymentDetailsTableViewCellDelegate: AnyObject {
    /// Called when the delete button is tapped.
    /// - Parameter cell: The cell in which the delete button was tapped.
    func didTapDeleteButton(in cell: PaymentDetailsTableViewCell)
}

/// A custom table view cell used to display saved payment card details.
class PaymentDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    /// Image view for displaying card-related icon.
    @IBOutlet weak var imgViewCart: UIImageView!
    
    /// Button to delete the saved card.
    @IBOutlet weak var btnDeleteCard: UIButton!
    
    /// Label to display masked card number.
    @IBOutlet weak var lblCardNo: UILabel!
    
    // MARK: - Properties
    /// Delegate to notify about delete button actions.
    weak var delegate: PaymentDetailsTableViewCellDelegate?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Style delete button with circular border
        btnDeleteCard.layer.cornerRadius = btnDeleteCard.frame.height / 2
        btnDeleteCard.layer.borderWidth = 1
        
        // Apply border color if available in asset catalog
        if let borderColor = UIColor(named: "login Background Color") {
            btnDeleteCard.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuration
    /// Configures the cell with a given card number.
    /// - Parameter cardNumber: The full card number as a `String`.
    ///
    /// Only the last 4 digits are displayed in masked format (e.g., `**** **** **** 1234`).
    func configure(with cardNumber: String) {
        let lastFourDigits = String(cardNumber.suffix(4))
        lblCardNo.text = "**** **** **** \(lastFourDigits)"
    }
    
    // MARK: - Actions
    /// Handles delete button tap and informs the delegate.
    @IBAction func btnDeleteCardAction(_ sender: Any) {
        delegate?.didTapDeleteButton(in: self)
    }
}
