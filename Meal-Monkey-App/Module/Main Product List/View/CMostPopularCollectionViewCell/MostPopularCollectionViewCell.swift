import UIKit

class MostPopularCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgMostPopular: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgMostPopular.layer.cornerRadius = 10
        imgMostPopular.layer.borderColor = UIColor.systemGray.cgColor
        imgMostPopular.layer.borderWidth = 0
    }
}
