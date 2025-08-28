//
//  CashOnDeliveryTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import UIKit

/// Custom UITableViewCell for displaying Cash On Delivery payment option in the checkout screen
class CashOnDeliveryTableViewCell: UITableViewCell {
    
    /// Stack view containing the Cash On Delivery UI elements
    @IBOutlet weak var stackView: UIStackView!
    
    /// Button to select Cash On Delivery as the payment method
    @IBOutlet weak var btnSelect: UIButton!
    
    // MARK: - Lifecycle Methods
    
    /// Called when the cell is loaded from the nib/storyboard
    /// Configures border, corner radius, and selection button appearance
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure stack view appearance
        stackView.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor
        stackView.layer.borderWidth = 1.0
        stackView.layer.cornerRadius = 10
        
        // Configure selection button appearance
        btnSelect.setImage(UIImage(systemName: "circle"), for: .normal)
        btnSelect.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        btnSelect.backgroundColor = .clear
        btnSelect.layer.cornerRadius = btnSelect.frame.height / 2
        btnSelect.clipsToBounds = true
    }
    
    /// Called when the selection state of the cell changes
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    
    /// Action triggered when the select button is tapped
    /// Intended to mark Cash On Delivery as the selected payment method (logic handled in parent view controller)
    @IBAction func btnSelectAction(_ sender: Any) {
    }
}
