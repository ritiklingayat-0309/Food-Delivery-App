//
//  MyOrderTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import UIKit

class MyOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configMyorder(product: ProductModel)
    {
        lblProductName.text = product.strProductName
        lblQty.text = "x \(product.intProductQty ?? 0)"
        lblTotal.text = "$\(String(format: "%.2f", product.doubleProductPrice * Double(product.intProductQty!)))"
    }
}
