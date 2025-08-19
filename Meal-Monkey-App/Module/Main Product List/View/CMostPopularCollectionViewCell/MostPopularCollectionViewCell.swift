//
//  MostPopularCollectionViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on --/--/25.
//  This class defines a custom collection view cell for displaying
//  the most popular food items, including their name, rating, category, and image.
//

import UIKit

/// A custom collection view cell that displays the most popular food items.
class MostPopularCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    /// Image view to display the most popular food item.
    @IBOutlet weak var imgMostPopular: UIImageView!
    
    /// Label to display the food name.
    @IBOutlet weak var lblFoodName: UILabel!
    
    /// Label to display the food rating.
    @IBOutlet weak var lblRatings: UILabel!
    
    /// Label to display the food category.
    @IBOutlet weak var lblFoodCategory: UILabel!
    
    // MARK: - Lifecycle Methods
    
    /// Called after the cell has been loaded from the nib.
    override func awakeFromNib() {
        super.awakeFromNib()
        imgMostPopular.layer.cornerRadius = 10
        imgMostPopular.layer.borderColor = UIColor.systemGray.cgColor
        imgMostPopular.layer.borderWidth = 0
    }
    
    // MARK: - Configuration
    
    /**
     Configures the cell with the given product model.
     
     - Parameter item: A `ProductModel` instance containing details
                      of the most popular food item.
     */
    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodCategory.text = item.objProductCategory.rawValue
        lblRatings.text = "\(item.floatProductRating)"
        imgMostPopular.image = UIImage(named: item.strProductImage)
    }
}
