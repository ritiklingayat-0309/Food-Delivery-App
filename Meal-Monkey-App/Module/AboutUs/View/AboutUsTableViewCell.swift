//
//  AboutUsTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

class AboutUsTableViewCell: UITableViewCell {
    //for each page data
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lbltitle2: UILabel!
    @IBOutlet weak var lblRightSidetitle: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configaboutcell(about: AboutModel) {
        lbltitle.text = about.strText
        lbltitle2.isHidden = true
        lblRightSidetitle.isHidden = true
        btnStar.isHidden = true
    }
    
    func configNotificationcell(about: AboutModel) {
        lbltitle.text = about.strText
        btnStar.isHidden = true
        lblRightSidetitle.isHidden = true
        lbltitle2.text = about.strTimezone
    }
    
    func configInboxcell(about: AboutModel) {
        lbltitle.text = about.strText
        btnStar.isHidden = false
        lblRightSidetitle.text = about.strRightSideText
        lbltitle2.text = about.strText2
    }
}
