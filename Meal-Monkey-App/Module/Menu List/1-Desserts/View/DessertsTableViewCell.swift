//
//  DessertsTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import UIKit

class DessertsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgViewTop: UIImageView!
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
    
    func configDessert(dessert: ProductModel) {
        self.lblDessertName.text = dessert.strProductName
        self.lblRating.text = "\(dessert.floatProductRating) (\(dessert.intTotalNumberOfRatings) ratings)"
        self.lblCategory.text = "\(dessert.objProductCategory)"
        self.imgViewTop.image = UIImage(named: dessert.strProductImage)
    }
}
