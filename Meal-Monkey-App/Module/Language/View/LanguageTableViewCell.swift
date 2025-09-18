//
//  LanguageTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/09/25.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCheckmark: UIImageView!
    @IBOutlet weak var ViewCell: UIView!
    @IBOutlet weak var lblLang: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewCell.layer.cornerRadius = 10
        ViewCell.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configLanguage(lang: SettingsModel, selectedTag: Int) {
        lblLang.text = lang.lang
        imgCheckmark.isHidden = (lang.inTag != selectedTag)
    }

    func configTheme(theme: SettingsModel, selectedThemeTag: Int) {
        lblLang.text = theme.theme
        imgCheckmark.isHidden = (theme.inTag != selectedThemeTag)
    }
}
