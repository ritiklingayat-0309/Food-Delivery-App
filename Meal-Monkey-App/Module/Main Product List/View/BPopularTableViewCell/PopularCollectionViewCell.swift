import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgPopular: UIImageView!
    @IBOutlet weak var lblFoodRating: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    @IBOutlet weak var lblFoodName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodRating.text = "\(item.floatProductRating)"
        lblFoodType.text = "\(item.objProductType.rawValue)"
        imgPopular.image = UIImage(named: item.strProductImage)
    }
}
