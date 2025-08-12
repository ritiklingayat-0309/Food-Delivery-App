
import UIKit

protocol HomeTableTableViewCellDelegate: AnyObject {
    func HomeTableViewCell(_ cell: HomeTableViewCell, didSelectProduct product: ProductModel)
    func HomeTableViewCell(_ cell: HomeTableViewCell, didSelectCategory category: ProductCategory)
}

class HomeTableViewCell: UITableViewCell {
    
    weak var delegate: HomeTableTableViewCellDelegate?
    @IBOutlet weak var lblCollectionViewTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var collectionViewHome: UICollectionView!
    @IBOutlet weak var collectionViewHomeHeight: NSLayoutConstraint!
    var collectionType: CollectionType = .category
    var selectedCategory: ProductCategory = .All
    
    enum CollectionType {
        case category
        case popular
        case mostPopular
        case RecentItems
    }
    
    var categories: [ProductCategory] = [] {
        didSet {
            collectionViewHome.reloadData()
            DispatchQueue.main.async {
                self.collectionViewHome.layoutIfNeeded()
                self.updateCollectionHeight()
            }
        }
    }
    
    var products: [ProductModel] = [] {
        didSet {
            collectionViewHome.reloadData()
            DispatchQueue.main.async {
                self.collectionViewHome.layoutIfNeeded()
                self.updateCollectionHeight()
            }
        }
    }
    
    func updateCollectionHeight() {
        if let layout = collectionViewHome.collectionViewLayout as? UICollectionViewFlowLayout,
           layout.scrollDirection == .vertical {
            self.collectionViewHomeHeight.constant = self.collectionViewHome.collectionViewLayout.collectionViewContentSize.height
        }
    }
    
  

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewHome.register(UINib(nibName: "HomeCategoryCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "HomeCategoryCollectionViewCell")
        collectionViewHome.register(UINib(nibName: "PopularCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "PopularCollectionViewCell")
        collectionViewHome.register(UINib(nibName: "MostPopularCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "MostPopularCollectionViewCell")
        collectionViewHome.register(UINib(nibName: "RecentItemsCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "RecentItemsCollectionViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnViewAllClick(_ sender: Any) {
    }
}

extension HomeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionType {
        case .category:
            return categories.count
        default:
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        switch collectionType {
        case .category:
            let cell: HomeCategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCollectionViewCell", for: indexPath) as! HomeCategoryCollectionViewCell
            let category = categories[indexPath.row]
            cell.configure(with: category)
            return cell
            
        case .popular:
            let cell: PopularCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
            let product = products[indexPath.row]
            cell.configure(with: product)
            return cell
            
        case .mostPopular:
            let cell: MostPopularCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MostPopularCollectionViewCell", for: indexPath) as! MostPopularCollectionViewCell
            let product = products[indexPath.row]
            cell.configure(with: product)
            return cell
            
        case .RecentItems:
            let cell: RecentItemsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentItemsCollectionViewCell", for: indexPath) as! RecentItemsCollectionViewCell
            let product = products[indexPath.row]
            cell.configure(with: product)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionType == .category {
            return CGSize(width: 88, height: 113)
        } else if collectionType == .popular {
            return CGSize(width:collectionViewHome.frame.width , height: 242.19)
        } else if collectionType == .mostPopular {
            return CGSize(width: 228, height: 185)
        } else if collectionType == .RecentItems {
            return CGSize(width: 296, height: 79)
        } else{
            return CGSize(width: 100, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionType {
        case .category:
            let selectedCategory = categories[indexPath.row]
            delegate?.HomeTableViewCell(self, didSelectCategory: selectedCategory)
        default:
            let selectedProduct = products[indexPath.row]
            delegate?.HomeTableViewCell(self, didSelectProduct: selectedProduct)
        }

    }
}
