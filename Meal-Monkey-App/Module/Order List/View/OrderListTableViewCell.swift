//
//  OrderListTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {

 
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(with products: [ProductModel], orderNumber: Int) {
        let allProductNames = products.map { $0.strProductName }.joined(separator: ", ")
        lblOrderNo.text = "Order No: \(orderNumber)"
        if let firstProduct = products.first {
            lblProductName.text = "Items : \(allProductNames) "
            lblTotal.text = "Price : $\(String(format : "%.2f", firstProduct.doubleProductPrice))"
            imgView.image = UIImage(named: firstProduct.strProductImage)

        }

    }
    
}
