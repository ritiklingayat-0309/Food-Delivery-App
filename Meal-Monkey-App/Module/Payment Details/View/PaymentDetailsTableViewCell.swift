//
//  PaymentDetailsTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import UIKit

protocol PaymentDetailsTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(in cell: PaymentDetailsTableViewCell)
}

class PaymentDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgViewCart: UIImageView!
    @IBOutlet weak var btnDeleteCard: UIButton!
    @IBOutlet weak var lblCardNo: UILabel!
    
    weak var delegate: PaymentDetailsTableViewCellDelegate?
    
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
    
    func configure(with cardNumber: String) {
        let lastFourDigits = String(cardNumber.suffix(4))
        lblCardNo.text = "**** **** **** \(lastFourDigits)"
    }
    
    @IBAction func btnDeleteCardAction(_ sender: Any) {
        delegate?.didTapDeleteButton(in: self)
    }
}
