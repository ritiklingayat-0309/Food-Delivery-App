//
//  HomeTableViewCell.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on --/--/25.
//  A custom table view cell that holds a collection view,
//  used to display categories, popular items, most popular items, and recent items.
//

import UIKit

// MARK: - Protocol

/// Delegate protocol to handle selection of products or categories from the collection view inside `HomeTableViewCell`.
protocol HomeTableTableViewCellDelegate: AnyObject {
    func HomeTableViewCell(_ cell: HomeTableViewCell, didSelectProduct product: ProductModel)
    func HomeTableViewCell(_ cell: HomeTableViewCell, didSelectCategory category: ProductCategory)
}

// MARK: - TableView Cell

/// A custom table view cell that embeds a collection view.
/// Displays categories or different types of products depending on `collectionType`.
class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var lblCollectionViewTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var collectionViewHome: UICollectionView!
    @IBOutlet weak var collectionViewHomeHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    
    weak var delegate: HomeTableTableViewCellDelegate?
    
    /// Defines the type of collection view content displayed.
    enum CollectionType {
        case category
        case popular
        case mostPopular
        case recentItems
    }
    
    /// Current collection type.
    var collectionType: CollectionType = .category
    
    /// Currently selected category.
    var selectedCategory: ProductCategory = .All
    
    /// List of categories to display.
    var categories: [ProductCategory] = [] {
        didSet {
            reloadCollection()
        }
    }
    
    /// List of products to display.
    var products: [ProductModel] = [] {
        didSet {
            reloadCollection()
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Setup Methods
    
    /// Registers custom collection view cells used inside this table view cell.
    private func setupCollectionView() {
        collectionViewHome.register(UINib(nibName: "HomeCategoryCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "HomeCategoryCollectionViewCell")
        collectionViewHome.register(UINib(nibName: "PopularCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "PopularCollectionViewCell")
        collectionViewHome.register(UINib(nibName: "MostPopularCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "MostPopularCollectionViewCell")
        collectionViewHome.register(UINib(nibName: "RecentItemsCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "RecentItemsCollectionViewCell")
    }
    
    /// Reloads collection view and updates height constraint.
    private func reloadCollection() {
        collectionViewHome.reloadData()
        DispatchQueue.main.async {
            self.collectionViewHome.layoutIfNeeded()
            self.updateCollectionHeight()
        }
    }
    
    /// Updates the collection view height based on its content size.
    func updateCollectionHeight() {
        if let layout = collectionViewHome.collectionViewLayout as? UICollectionViewFlowLayout,
           layout.scrollDirection == .vertical {
            self.collectionViewHomeHeight.constant =
                self.collectionViewHome.collectionViewLayout.collectionViewContentSize.height
        }
    }
    
    // MARK: - Actions
    
    @IBAction func btnViewAllClick(_ sender: Any) {
        // TODO: Handle View All button action if needed
    }
}

// MARK: - CollectionView Delegate & DataSource

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
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "HomeCategoryCollectionViewCell",
                for: indexPath
            ) as! HomeCategoryCollectionViewCell
            cell.configure(with: categories[indexPath.row])
            return cell
            
        case .popular:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PopularCollectionViewCell",
                for: indexPath
            ) as! PopularCollectionViewCell
            cell.configure(with: products[indexPath.row])
            return cell
            
        case .mostPopular:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "MostPopularCollectionViewCell",
                for: indexPath
            ) as! MostPopularCollectionViewCell
            cell.configure(with: products[indexPath.row])
            return cell
            
        case .recentItems:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "RecentItemsCollectionViewCell",
                for: indexPath
            ) as! RecentItemsCollectionViewCell
            cell.configure(with: products[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionType {
        case .category:
            return CGSize(width: 88, height: 113)
        case .popular:
            return CGSize(width: collectionViewHome.frame.width, height: 242.19)
        case .mostPopular:
            return CGSize(width: 228, height: 185)
        case .recentItems:
            return CGSize(width: 296, height: 79)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionType {
        case .category:
            delegate?.HomeTableViewCell(self, didSelectCategory: categories[indexPath.row])
        default:
            delegate?.HomeTableViewCell(self, didSelectProduct: products[indexPath.row])
        }
    }
}
