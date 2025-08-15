//
//  MenuTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblFoodQuntity: UILabel!
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var btnArrow: UIButton!

    
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
    
    
    @IBAction func btnArrowAction(_ sender: Any) {
    }
}
