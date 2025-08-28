//
//  RecentItemsCollectionViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on --/--/25.
//  This class defines a custom collection view cell for displaying
//  recently viewed or ordered food items, including their image, name,
//  rating, total number of ratings, and type.
//

import UIKit

/// A custom collection view cell that displays recently viewed or ordered food items.
class RecentItemsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    /// Image view to display the recent food item.
    @IBOutlet weak var imgRecentItem: UIImageView!
    
    /// Label to display the food rating.
    @IBOutlet weak var lblFoodRating: UILabel!
    
    /// Label to display the total number of ratings for the food item.
    @IBOutlet weak var lblTotalNoOfRatings: UILabel!
    
    /// Label to display the food type.
    @IBOutlet weak var lblFoodType: UILabel!
    
    /// Label to display the food name.
    @IBOutlet weak var lblFoodName: UILabel!
    
    // MARK: - Lifecycle Methods
    
    /// Called after the cell has been loaded from the nib.
    override func awakeFromNib() {
        super.awakeFromNib()
        imgRecentItem.layer.cornerRadius = 10
        imgRecentItem.layer.borderColor = UIColor.systemGray.cgColor
        imgRecentItem.layer.borderWidth = 0
    }
    
    // MARK: - Configuration
    
    /**
     Configures the cell with the given product model.
     
     - Parameter item: A `ProductModel` instance containing details
                      of the recent food item.
     */
    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodType.text = item.objProductType.rawValue
        lblFoodRating.text = "\(item.floatProductRating)"
        lblTotalNoOfRatings.text = "\(item.intTotalNumberOfRatings)"
        imgRecentItem.image = UIImage(named: item.strProductImage)
    }
}
