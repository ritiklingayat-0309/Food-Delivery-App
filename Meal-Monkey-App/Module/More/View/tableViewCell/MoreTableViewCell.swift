//
//  MoreTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

class MoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblMore: UILabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnArrow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMain.layer.cornerRadius = 7
        imgView.layer.cornerRadius = 28
        btnArrow.layer.cornerRadius = 50
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configMoreData(more : More) {
        imgView.image = more.image
        lblMore.text = more.title
    }
    
    @IBAction func btnArrowAction(_ sender: Any) {
        
    }
    
    
}
