//
//  FeaturesCollectionViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

/// `FeaturesCollectionViewCell`
///
/// A custom `UICollectionViewCell` used to display feature items in a collection view.
/// It contains an image view that represents a feature.
class FeaturesCollectionViewCell: UICollectionViewCell {
    
    /// Image view to display the feature image.
    @IBOutlet weak var imgView: UIImageView!
    
    // MARK: - Lifecycle
    
    /// Called after the cell has been loaded from Interface Builder.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configuration
    /// Configures the cell with a given `Features` object.
    /// - Parameter features: The `Features` model containing the image to display.
    func configFeature(features: Features) {
        imgView.image = features.image
    }
}
