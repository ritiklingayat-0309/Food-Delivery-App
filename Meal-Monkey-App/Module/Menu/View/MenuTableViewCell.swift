//
//  MenuTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodQuntity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configMenu(menu : Menu) {
        if let imageName = menu.img {
            imgFood.image = UIImage(named: imageName)
        } else {
            imgFood.image = nil
        }
        lblFoodName.text = menu.foodName
        lblFoodQuntity.text = "\(menu.quantity) items"
    }
}
