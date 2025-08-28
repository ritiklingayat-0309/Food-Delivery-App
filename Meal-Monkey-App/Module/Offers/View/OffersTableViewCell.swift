//
//  OffersTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import UIKit

/// `OffersTableViewCell`
///
/// A custom table view cell used to display café/restaurant offers.
/// This cell shows:
/// - Café image
/// - Café name
/// - Ratings
/// - Restaurant type
/// - Food type
class OffersTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    /// Image view for displaying café/restaurant image.
    @IBOutlet weak var imgView: UIImageView!
    
    /// Label for displaying café name.
    @IBOutlet weak var lblcafeName: UILabel!
    
    /// Label for displaying ratings.
    @IBOutlet weak var lblRating: UILabel!
    
    /// Label for displaying restaurant type.
    @IBOutlet weak var lblRestrotype: UILabel!
    
    /// Label for displaying food type (e.g., Italian, Chinese).
    @IBOutlet weak var lblFoodType: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code runs when cell is loaded from nib.
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure selection behavior if needed.
    }
    
    // MARK: - Configuration
    /// Configures the cell with given offer data.
    ///
    /// - Parameter offer: The `offer` model containing details of the café/restaurant.
    ///
    /// The method:
    /// - Sets café image.
    /// - Updates name, rating, type, and food type labels.
    func configOffer(offer: offer) {
        // Set café image.
        imgView.image = UIImage(named: "\(offer.imageCafe)")
        
        // Set café name.
        lblcafeName.text = offer.strCafeName
        
        // Set café rating.
        lblRating.text = offer.strNoOfRatings
        
        // Set restaurant type (currently reusing café name).
        lblRestrotype.text = "\(offer.strCafeName)"
        
        // Set food type.
        lblFoodType.text = "\(offer.strFoodType)"
    }
}
