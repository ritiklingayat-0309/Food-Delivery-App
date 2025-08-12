//
//  PaymentDetailsTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import UIKit

class PaymentDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgViewCart: UIImageView!
    @IBOutlet weak var btnDeleteCard: UIButton!
    @IBOutlet weak var lblCardNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnDeleteCard.layer.cornerRadius = btnDeleteCard.frame.height/2
        btnDeleteCard.layer.borderWidth = 1
        if let borderColor = UIColor(named: "login Background Color") {
            btnDeleteCard.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func btnDeleteCardAction(_ sender: Any) {
    }
}
