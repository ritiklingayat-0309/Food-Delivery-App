//
//  CartTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 10/08/25.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblProductType: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblQuntity: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    var onLike: (() -> Void)?
    var onDelete: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with product: ProductModel) {
        lblProductName.text = product.strProductName
        lblDescription.text = product.strProductDescription
        imgProduct.image = UIImage(named: product.strProductImage)
        lblPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice))"
        lblProductType.text = product.objProductType.rawValue.capitalized
        lblCategory.text = product.objProductCategory.rawValue
        lblQuntity.text = "QTY: \(product.intProductQty ?? 1)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnDeleteAction(_ sender: Any) {
        onDelete?()
    }
    
    @IBAction func btnLikeAction(_ sender: Any) {
        onLike?()
    }
}
