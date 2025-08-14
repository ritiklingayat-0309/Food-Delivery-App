//
//  CashOnDeliveryTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import UIKit

class CashOnDeliveryTableViewCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var btnSelect: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        stackView.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor
        stackView.layer.borderWidth = 1.0
        stackView.layer.cornerRadius = 10
        
        btnSelect.setImage(UIImage(systemName: "circle"), for: .normal)
        btnSelect.setImage(UIImage(systemName: "circle.fill"), for: .selected)
       
        btnSelect.backgroundColor = .clear
        btnSelect.layer.cornerRadius = btnSelect.frame.height / 2
        btnSelect.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnSelectAction(_ sender: Any) {
    }
}
