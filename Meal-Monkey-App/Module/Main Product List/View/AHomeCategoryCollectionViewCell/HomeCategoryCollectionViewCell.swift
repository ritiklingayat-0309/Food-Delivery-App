import UIKit

class HomeCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgCategory.layer.cornerRadius = 10
        imgCategory.layer.borderColor = UIColor.systemGray.cgColor
        imgCategory.layer.borderWidth = 0
    }
    
    func configure(with category: ProductCategory) {
        
        lblCategory.text = category.rawValue
     
        switch category {
        case .All:
            imgCategory.image = UIImage(named: "ic_butternaan")
        case .Punjabi:
            imgCategory.image = UIImage(named: "ic_paneertikka")
        case .Chinese:
            imgCategory.image = UIImage(named: "ic_hakkanoodles")
        case .Gujarati:
            imgCategory.image = UIImage(named: "Ic_Khaman_Dhokla")
        case .SouthIndian:
            imgCategory.image = UIImage(named: "ic_masaladosa")
        case .WesternFood:
            imgCategory.image = UIImage(named: "ic_margherita_pizza")
        }
    }
}
