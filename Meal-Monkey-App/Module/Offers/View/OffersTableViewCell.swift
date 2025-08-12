//
//  OffersTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import UIKit

class OffersTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblcafeName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblRestrotype: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configOffer(offer : offer)
    {
        imgView.image = UIImage(named: "\(offer.imageCafe)")
        lblcafeName.text = offer.strCafeName
        lblRating.text = offer.strNoOfRatings
        lblRestrotype.text = "\(offer.strCafeName)"
        lblFoodType.text = "\(offer.strFoodType)"
    }
}
