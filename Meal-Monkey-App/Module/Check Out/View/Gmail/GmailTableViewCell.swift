//
//  GmailTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import UIKit

/// Custom UITableViewCell for displaying a Gmail payment option in the checkout screen
class GmailTableViewCell: UITableViewCell {
    
    /// Button to select Gmail as the payment method
    @IBOutlet weak var btncircle: UIButton!
    
    /// Label to display the email address
    @IBOutlet weak var lblEmail: UILabel!
    
    /// Stack view containing Gmail UI elements
    @IBOutlet weak var stacViewGmail: UIStackView!
    
    // MARK: - Lifecycle Methods
    
    /// Called when the cell is loaded from the nib/storyboard
    /// Configures border, corner radius, and button appearance
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure Gmail stack view appearance
        stacViewGmail.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor
        stacViewGmail.layer.borderWidth = 1.0
        stacViewGmail.layer.cornerRadius = 10
        
        // Configure selection button appearance
        btncircle.setImage(UIImage(systemName: "circle"), for: .normal)
        btncircle.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        btncircle.backgroundColor = .clear
        btncircle.layer.cornerRadius = btncircle.frame.height / 2
        btncircle.clipsToBounds = true
    }
    
    /// Called when the selection state of the cell changes
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    
    /// Action triggered when the Gmail selection button is tapped
    /// Intended to mark Gmail as the selected payment method (logic handled in parent view controller)
    @IBAction func btnCircleAction(_ sender: Any) {
    }
}
