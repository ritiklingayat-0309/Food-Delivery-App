//
//  DessertsViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import UIKit

/// ViewController responsible for displaying dessert items (or other product categories).
/// Handles search, filtering, navigation, and styling for product listing.
class DessertsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    // MARK: - Properties
    
    /// Currently selected product type (e.g., Food, Beverages, Desserts)
    var selectedProductType: ProductType = .Desserts
    
    /// Stores filtered products based on search or full list by default
    var filteredProducts: [ProductModel] = []
    
    /// Computed property that fetches all products of the selected type
    var arrProducts: [ProductModel] {
        return HomeViewController.arrProductData.filter { $0.objProductType == selectedProductType }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide table view scroll indicator
        tblView.showsVerticalScrollIndicator = false
        
        // Add cart button to navigation bar
        self.setCartButton(target: self, action: #selector(cartButtonTapped))
        
        // Configure navigation title based on selected product type
        switch selectedProductType {
        case .food:
            setLeftAlignedTitleWithBack(
                "Food",
                target: self,
                action: #selector(backButtonTapped)
            )
        case .Beverages:
            setLeftAlignedTitleWithBack(
                "Beverages",
                target: self,
                action: #selector(backButtonTapped)
            )
        case .Desserts:
            setLeftAlignedTitleWithBack(
                "Desserts",
                target: self,
                action: #selector(backButtonTapped)
            )
        }
        
        // Register custom table view cell
        tblView.register(
            UINib(nibName: "DessertsTableViewCell", bundle: nil),
            forCellReuseIdentifier: "DessertsTableViewCell"
        )
        
        // Assign delegates
        tblView.dataSource = self
        tblView.delegate = self
        txtSearch.delegate = self
        
        // Apply styling and padding to search text field
        viewStyle(textfield: [txtSearch])
        setPadding(textfield: [txtSearch])
        
        // Load products initially
        filteredProducts = arrProducts
    }
    
    // MARK: - Navigation Actions
    
    /// Navigates back to the previous screen
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    /// Opens CartViewController when cart button is tapped
    @objc func cartButtonTapped() {
        print("Cart tapped")
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            secondVC.pagetype = .Cart
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    // MARK: - Styling Helpers
    
    /// Applies custom view style (corner radius, border, etc.) to given views
    func viewStyle(textfield: [UIView]) {
        for item in textfield {
            item.viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray)
        }
    }
    
    /// Adds left and right padding to given textfields
    func setPadding(textfield: [UITextField]) {
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
}
