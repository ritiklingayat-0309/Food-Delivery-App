import UIKit

class MostPopularCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgMostPopular: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblRatings: UILabel!
    @IBOutlet weak var lblFoodCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgMostPopular.layer.cornerRadius = 10
        imgMostPopular.layer.borderColor = UIColor.systemGray.cgColor
        imgMostPopular.layer.borderWidth = 0
    }
    
    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodCategory.text = item.objProductCategory.rawValue
        lblRatings.text = "\(item.floatProductRating)"
        imgMostPopular.image = UIImage(named: item.strProductImage)
    }
    
}
