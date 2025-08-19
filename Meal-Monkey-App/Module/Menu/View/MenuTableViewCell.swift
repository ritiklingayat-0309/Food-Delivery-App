//
//  MenuTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import UIKit

/// Custom table view cell to display menu items in the Menu list.
class MenuTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    /// Label to display the quantity of food items.
    @IBOutlet weak var lblFoodQuntity: UILabel!
    
    /// Image view to display the food image.
    @IBOutlet weak var imgFood: UIImageView!
    
    /// Label to display the food name.
    @IBOutlet weak var lblFoodName: UILabel!
    
    /// Button for the right arrow (navigation/selection).
    @IBOutlet weak var btnArrow: UIButton!
    
    // MARK: - Lifecycle Methods
    
    /// Called after the cell is loaded from Interface Builder.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Configures the selection state of the cell.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuration
    
    /// Configures the cell with data from a `Menu` object.
    /// - Parameter menu: The `Menu` model containing image, name, and quantity.
    func configMenu(menu: Menu) {
        if let imageName = menu.img {
            imgFood.image = UIImage(named: imageName)
        } else {
            imgFood.image = nil
        }
        lblFoodName.text = menu.foodName
        lblFoodQuntity.text = "\(menu.quantity) items"
    }
    
    // MARK: - Actions
    
    /// Action triggered when the arrow button is tapped.
    @IBAction func btnArrowAction(_ sender: Any) {
        // Action handling logic can be added here
    }
}
