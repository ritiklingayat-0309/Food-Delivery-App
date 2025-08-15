//
//  HomeViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 11/08/25.
//

import UIKit

class HomeViewController: UIViewController , HomeTableTableViewCellDelegate , UITextFieldDelegate ,MapViewControllerDelegate{
   
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var btnAddressDropdown: UIButton!
    var selectedCategory: ProductCategory = .All
    var recentItems: [ProductModel] = []
    var arrProductData: [ProductModel] = ProductModel.addProductData()
    var objProductCategory: ProductModel?
    var filteredProductData: [ProductModel] = [] 
    
    override func viewWillAppear(_ animated: Bool) {
        recentItems = RecentItemsHelper.shared.getRecentItems()
        tblView.reloadData()
        filterProducts(with: txtSearch.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitle("Good morning Ritik!")
        setCartButton(target: self, action: #selector(btnCartTapped))
        EditStyle.setborder(textfields: [txtSearch])
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 28)
        tblView.showsVerticalScrollIndicator = false
        tblView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        
        txtSearch.delegate = self
        filteredProductData = arrProductData
        if let savedAddress = UserDefaults.standard.string(forKey: "savedAddress") {
               lblAddress.text = savedAddress
           }
        
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
    
    func didSelectAddress(_ address: String) {
         lblAddress.text = address
    }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            secondVC.pagetype = .Cart
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
        filterProducts(with: txtSearch.text) // added new
        selectedCategory = category
    }
    // Use this method for real-time filtering as the user types
    func textFieldDidChangeSelection(_ textField: UITextField) {
           filterProducts(with: textField.text)
       }
       
    
    @IBAction func btnDropDownClick(_ sender: Any) {
    }
    // Method to handle filtering of products
    func filterProducts(with searchText: String?) {
        if let text = searchText, !text.isEmpty {
            let lowercaseText = text.lowercased()
            filteredProductData = arrProductData.filter { product in
                // Check if the product name or the product category contains the search text
                let productNameMatches = product.strProductName.lowercased().contains(lowercaseText)
                let productCategoryMatches = product.objProductCategory.rawValue.lowercased().contains(lowercaseText)
                return productNameMatches || productCategoryMatches
            }
        } else {
            // If the search bar is empty, show all products
            filteredProductData = arrProductData
        }
        
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
        
        
    }
}
