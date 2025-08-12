//
//  HomeViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 11/08/25.
//

import UIKit

class HomeViewController: UIViewController , HomeTableTableViewCellDelegate{
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
  
    var selectedCategory: ProductCategory = .All
    var recentItems: [ProductModel] = []
    var arrProductData: [ProductModel] = ProductModel.addProductData()
    var objProductCategory: ProductModel?
    
    override func viewWillAppear(_ animated: Bool) {
        recentItems = RecentItemsHelper.shared.getRecentItems()
        tblView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitle("Good morning Ritik!")
        setCartButton(target: self, action: #selector(btnCartTapped))
        EditStyle.setborder(textfields: [txtSearch])
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 28)
        tblView.showsVerticalScrollIndicator = false
        tblView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    func HomeTableViewCell(_ cell: HomeTableViewCell, didSelectProduct product: ProductModel) {
        RecentItemsHelper.shared.addProduct(product)
        
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ItemDetailsViewController") as? ItemDetailsViewController {
            detailVC.selectedProduct = product
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        recentItems = RecentItemsHelper.shared.getRecentItems()
        tblView.reloadData()
    }
    func HomeTableViewCell(_ cell: HomeTableViewCell, didSelectCategory category: ProductCategory) {
        selectedCategory = category
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }

}
