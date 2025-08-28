//
//  MoreTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

/// Custom table view cell used in the "More" section.
/// Displays an image, title label, and an arrow button.
class MoreTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    /// Icon image for the menu item
    @IBOutlet weak var imgView: UIImageView!
    
    /// Label displaying the title of the menu item
    @IBOutlet weak var lblMore: UILabel!
    
    /// Main container view inside the cell
    @IBOutlet weak var viewMain: UIView!
    
    /// Arrow button on the right side of the cell
    @IBOutlet weak var btnArrow: UIButton!
    
    
    // MARK: - Lifecycle Methods
    
    /// Called after the cell has been loaded from the nib/storyboard.
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply rounded corners to the main container
        viewMain.layer.cornerRadius = 7
        
        // Make the image view circular (assuming 56x56 size approx.)
        imgView.layer.cornerRadius = 28
        
        // Make the arrow button circular
        btnArrow.layer.cornerRadius = 50
    }
    
    /// Called when the cell’s selection state changes.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Custom selection styling can be added here if needed
    }
    
    // MARK: - Configuration
    
    /// Configures the cell with data from a `More` model object.
    /// - Parameter more: The `More` model containing image and title.
    func configMoreData(more: More) {
        imgView.image = more.image
        lblMore.text = more.title
    }
    
    // MARK: - Actions
    
    /// Action triggered when the arrow button is tapped.
    @IBAction func btnArrowAction(_ sender: Any) {
        // TODO: Add functionality if arrow button needs an action
    }
}
