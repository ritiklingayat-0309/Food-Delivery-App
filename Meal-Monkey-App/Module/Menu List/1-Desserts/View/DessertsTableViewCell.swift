//
//  DessertsTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import UIKit

class DessertsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgViewTop: UIImageView!
//    @IBOutlet weak var imgViewbottom: UIImageView!
    @IBOutlet weak var lblDessertName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblRestroName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // This is the function you need to add to your cell class
       func configDessert(dessert: ProductModel) {
           // Set the product name and description
           self.lblDessertName.text = dessert.strProductName
           self.lblRestroName.text = dessert.strProductDescription
           
           // Set the rating
           self.lblRating.text = "\(dessert.floatProductRating) (\(dessert.intTotalNumberOfRatings) ratings)"
           
           // Set the category
           // The enum's raw value can be used, or you can format it as needed
           self.lblCategory.text = "\(dessert.objProductCategory)"
           
           // Load the image (assuming the image name matches an asset in your project)
           self.imgViewTop.image = UIImage(named: dessert.strProductImage)
           
           // The bottom image view seems to be a placeholder or for a secondary image.
           // If it's for a fixed image (like a star rating icon), you can set it here too.
           // For example:
           // self.imgViewbottom.image = UIImage(named: "star_icon")
       }
}
