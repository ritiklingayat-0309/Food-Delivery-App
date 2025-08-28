//
//  VisaTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import UIKit

/// Custom UITableViewCell for displaying a Visa card in the checkout screen
class VisaTableViewCell: UITableViewCell {
    
    /// Label to display masked card number (e.g., **** **** **** 1234)
    @IBOutlet weak var lblCardNo: UILabel!
    
    /// Stack view containing the Visa card UI elements
    @IBOutlet weak var stackViewVisa: UIStackView!
    
    /// Button to select this payment option
    @IBOutlet weak var btnSelect: UIButton!
    
    // MARK: - Lifecycle Methods
    
    /// Called when the cell is loaded from the nib/storyboard
    /// Configures border, corner radius, and button appearance
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure card stack view appearance
        stackViewVisa.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor
        stackViewVisa.layer.borderWidth = 1.0
        stackViewVisa.layer.cornerRadius = 10
        
        // Configure selection button appearance
        btnSelect.setImage(UIImage(systemName: "circle"), for: .normal)
        btnSelect.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        btnSelect.backgroundColor = .clear
        btnSelect.layer.cornerRadius = btnSelect.frame.height / 2
        btnSelect.clipsToBounds = true
        
        // Disable default cell selection style
        self.selectionStyle = .none
    }
    
    /// Called when the selection state of the cell changes
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    
    /// Action triggered when the select button is tapped
    /// Intended to mark this card as selected (logic handled in parent view controller)
    @IBAction func btnSelectAction(_ sender: Any) {
    }
}
