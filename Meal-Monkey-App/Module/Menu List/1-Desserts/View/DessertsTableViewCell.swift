//
//  DessertsTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import UIKit

/// A custom table view cell used to display dessert items.
class DessertsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    /// Dessert image displayed at the top.
    @IBOutlet weak var imgViewTop: UIImageView!
    
    /// Dessert name label.
    @IBOutlet weak var lblDessertName: UILabel!
    
    /// Dessert rating with total number of ratings.
    @IBOutlet weak var lblRating: UILabel!
    
    /// Name of the restaurant serving the dessert.
    @IBOutlet weak var lblRestroName: UILabel!
    
    /// Category of the dessert (e.g., Cake, Ice Cream).
    @IBOutlet weak var lblCategory: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuration
    
    /// Configures the cell with dessert product data.
    /// - Parameter dessert: The `ProductModel` representing a dessert.
    func configDessert(dessert: ProductModel) {
        lblDessertName.text = dessert.strProductName
        lblRating.text = "\(dessert.floatProductRating) (\(dessert.intTotalNumberOfRatings) ratings)"
        lblCategory.text = "\(dessert.objProductCategory)"
        imgViewTop.image = UIImage(named: dessert.strProductImage)
    }
}
