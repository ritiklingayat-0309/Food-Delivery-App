//
//  AboutUsTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

/**
 A custom table view cell used to display content for the "About Us," "Notifications," and "Inbox" screens.
 This cell is designed with multiple labels and a button that can be configured to show different types of data, depending on the screen.
 */
class AboutUsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lbltitle2: UILabel!
    @IBOutlet weak var lblRightSidetitle: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var lblRightSidetitleHeight:
    NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuration Methods
    
    /**
     Configures the cell to display data for the "About Us" screen.
     This method shows only the main title label and hides all other UI elements to present a clean, text-based cell.
     - Parameter about: The `AboutModel` object containing the data to display.
     */
    func configaboutcell(about: AboutModel) {
        lbltitle.text = about.strText
        lbltitle2.isHidden = true
        lblRightSidetitle.isHidden = true
        lblRightSidetitleHeight.constant = 0
        btnStar.isHidden = true
    }
    
    /**
     Configures the cell to display data for the "Notifications" screen.
     This method shows the main title and a time-related label, hiding other elements.
     - Parameter about: The `AboutModel` object containing the data to display.
     */
    func configNotificationcell(about: AboutModel) {
        lbltitle.text = about.strText
        btnStar.isHidden = true
        lblRightSidetitle.isHidden = true
        lbltitle2.text = about.strTimezone
    }
    
    /**
     Configures the cell to display data for the "Inbox" screen.
     This method shows multiple labels and a star button to represent a message with a subject, date, and subtitle.
     - Parameter about: The `AboutModel` object containing the data to display.
     */
    func configInboxcell(about: AboutModel) {
        lbltitle.text = about.strText
        btnStar.isHidden = false
        lblRightSidetitle.text = about.strRightSideText
        lbltitle2.text = about.strText2
    }
}
