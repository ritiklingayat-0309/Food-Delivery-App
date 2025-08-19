//
//  HomeCategoryCollectionViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on --/--/25.
//  This class represents a custom collection view cell used to display
//  different food categories on the home screen.
//

import UIKit

/// A custom collection view cell to represent a food category with an image and label.
class HomeCategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    /// Image view to display the category image.
    @IBOutlet weak var imgCategory: UIImageView!
    
    /// Label to display the category name.
    @IBOutlet weak var lblCategory: UILabel!
    
    // MARK: - Lifecycle Methods
    
    /// Called after the cell has been loaded from the nib.
    override func awakeFromNib() {
        super.awakeFromNib()
        imgCategory.layer.cornerRadius = 10
        imgCategory.layer.borderColor = UIColor.systemGray.cgColor
        imgCategory.layer.borderWidth = 0
    }
    
    // MARK: - Configuration
    
    /**
     Configures the cell with a given product category.
     
     - Parameter category: The product category used to set the label and image.
     */
    func configure(with category: ProductCategory) {
        lblCategory.text = category.rawValue
        
        switch category {
        case .All:
            imgCategory.image = UIImage(named: "ic_butternaan")
        case .Punjabi:
            imgCategory.image = UIImage(named: "ic_paneertikka")
        case .Chinese:
            imgCategory.image = UIImage(named: "ic_hakkanoodles")
        case .Gujarati:
            imgCategory.image = UIImage(named: "Ic_Khaman_Dhokla")
        case .SouthIndian:
            imgCategory.image = UIImage(named: "ic_masaladosa")
        case .WesternFood:
            imgCategory.image = UIImage(named: "ic_margherita_pizza")
        }
    }
}
