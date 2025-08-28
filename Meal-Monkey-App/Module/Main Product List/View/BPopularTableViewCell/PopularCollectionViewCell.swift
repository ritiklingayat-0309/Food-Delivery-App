//
//  PopularCollectionViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on --/--/25.
//  This class represents a custom collection view cell used to display
//  popular food items with their details such as name, rating, type, and image.
//

import UIKit

/// A custom collection view cell that displays popular food items.
class PopularCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    /// Image view for displaying the popular food item.
    @IBOutlet weak var imgPopular: UIImageView!
    
    /// Label for displaying the food rating.
    @IBOutlet weak var lblFoodRating: UILabel!
    
    /// Label for displaying the food type.
    @IBOutlet weak var lblFoodType: UILabel!
    
    /// Label for displaying the food name.
    @IBOutlet weak var lblFoodName: UILabel!
    
    // MARK: - Lifecycle Methods
    
    /// Called after the cell has been loaded from the nib.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configuration
    
    /**
     Configures the cell with a given product model.
     
     - Parameter item: A `ProductModel` instance containing details of the food item.
     */
    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodRating.text = "\(item.floatProductRating)"
        lblFoodType.text = "\(item.objProductType.rawValue)"
        imgPopular.image = UIImage(named: item.strProductImage)
    }
}
