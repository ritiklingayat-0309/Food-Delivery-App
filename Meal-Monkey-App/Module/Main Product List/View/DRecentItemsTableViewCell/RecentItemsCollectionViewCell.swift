import UIKit

class RecentItemsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgRecentItem: UIImageView!
    @IBOutlet weak var lblFoodRating: UILabel!
    @IBOutlet weak var lblTotalNoOfRatings: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    @IBOutlet weak var lblFoodName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgRecentItem.layer.cornerRadius = 10
        imgRecentItem.layer.borderColor = UIColor.systemGray.cgColor
        imgRecentItem.layer.borderWidth = 0
    }
    
    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodType.text = item.objProductType.rawValue
        lblFoodRating.text = "\(item.floatProductRating)"
        lblTotalNoOfRatings.text = "\(item.intTotalNumberOfRatings)"
        imgRecentItem.image = UIImage(named: item.strProductImage)
    }

}
