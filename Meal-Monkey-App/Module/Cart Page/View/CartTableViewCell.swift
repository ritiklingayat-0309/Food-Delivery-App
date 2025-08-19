//
//  CartTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 10/08/25.
//

import UIKit

/**
 A custom table view cell used to display a single product in the user's shopping cart or wishlist.
 
 This cell is responsible for displaying the product's image, name, price, and other details. It also
 contains action buttons for deleting or liking an item, handled by closures.
 */
class CartTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    /// The image view for displaying the product's image.
    @IBOutlet weak var imgProduct: UIImageView!
    
    /// The label that displays the product's price.
    @IBOutlet weak var lblPrice: UILabel!
    
    /// The label that displays the product's type.
    @IBOutlet weak var lblProductType: UILabel!
    
    /// The label that displays the product's name.
    @IBOutlet weak var lblProductName: UILabel!
    
    /// The button used to delete an item from the cart.
    @IBOutlet weak var btnDelete: UIButton!
    
    /// The label that displays the quantity of the product.
    @IBOutlet weak var lblQuntity: UILabel!
    
    /// The label that displays the product's category.
    @IBOutlet weak var lblCategory: UILabel!
    
    /// The button used to add or remove an item from the wishlist.
    @IBOutlet weak var btnLike: UIButton!
    
    // MARK: - Action Closures
    
    /// A closure that is called when the like/heart button is tapped.
    var onLike: (() -> Void)?
    
    /// A closure that is called when the delete button is tapped.
    var onDelete: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /**
     Configures the cell with a `ProductModel` object.
     
     This method populates all the labels and the image view of the cell
     using the data from the provided product model.
     
     - Parameter product: The `ProductModel` object containing the data to display.
     */
    func configure(with product: ProductModel) {
        lblProductName.text = product.strProductName
        imgProduct.image = UIImage(named: product.strProductImage)
        lblPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice))"
        lblProductType.text = product.objProductType.rawValue.capitalized
        lblCategory.text = product.objProductCategory.rawValue
        lblQuntity.text = "QTY: \(product.intProductQty ?? 1)"
        imgProduct.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    
    /**
     Handles the action for the delete button.
     
     This method calls the `onDelete` closure if it is not nil.
     
     - Parameter sender: The button that triggered the action.
     */
    @IBAction func btnDeleteAction(_ sender: Any) {
        onDelete?()
    }
    
    /**
     Handles the action for the like button.
     
     This method calls the `onLike` closure if it is not nil.
     
     - Parameter sender: The button that triggered the action.
     */
    @IBAction func btnLikeAction(_ sender: Any) {
        onLike?()
    }
}
