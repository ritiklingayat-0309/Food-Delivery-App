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
    static var arrProductData: [ProductModel] = []//API
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
        filteredProductData = HomeViewController.arrProductData
        if let savedAddress = UserDefaults.standard.string(forKey: "savedAddress") {
               lblAddress.text = savedAddress
           }
        
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
        
        fetchProductDataFromAPI()
    }
    
    private func fetchProductDataFromAPI() {
           // 🚨 IMPORTANT: Replace "YOUR_API_ENDPOINT_URL_HERE" with your actual URL.
           let apiURLString = "https://mocki.io/v1/02f731b0-da61-4bca-8412-88dedb1533cb"
           
           APICalls.getData(from: apiURLString) { [weak self] (products: [ProductModel]) in
               guard let self = self else { return }
               
               // This closure runs on a background thread. All UI updates must be on the main thread.
               DispatchQueue.main.async {
                   if !products.isEmpty {
                       HomeViewController.arrProductData = products
                       self.filterProducts(with: self.txtSearch.text)
                   } else {
                       // Handle case where products array is empty (e.g., failed to fetch or decode)
                       print("Could not fetch products or received an empty list.")
                       // You might want to show an alert to the user here.
                       let alert = UIAlertController(title: "Error", message: "Failed to load products. Please try again.", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       self.present(alert, animated: true, completion: nil)
                   }
                   self.tblView.reloadData()
                   print("Data is comming form api")
               }
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
            filteredProductData = HomeViewController.arrProductData.filter { product in
                // Check if the product name or the product category contains the search text
                let productNameMatches = product.strProductName.lowercased().contains(lowercaseText)
                let productCategoryMatches = product.objProductCategory.rawValue.lowercased().contains(lowercaseText)
                return productNameMatches || productCategoryMatches
            }
        } else {
            // If the search bar is empty, show all products
            filteredProductData = HomeViewController.arrProductData
        }
        
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
        
        
    }
}
