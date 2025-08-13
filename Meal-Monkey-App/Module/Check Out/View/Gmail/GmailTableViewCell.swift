//
//  GmailTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import UIKit

class GmailTableViewCell: UITableViewCell {

    @IBOutlet weak var btncircle: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var stacViewGmail: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        stacViewGmail.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor
        stacViewGmail.layer.borderWidth = 1.0
        stacViewGmail.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnCircleAction(_ sender: Any) {
    }
}
