//
//  HomeViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 11/08/25.
//

import UIKit
import CoreData

/// The main home screen controller responsible for displaying categories, recent items,
/// product list, and handling search & address selection.
class HomeViewController: UIViewController, HomeTableTableViewCellDelegate, UITextFieldDelegate, MapViewControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnAddressDropdown: UIButton!
    
    // MARK: - Properties
    var selectedCategory: ProductCategory = .All
    var arrrecentItems: [ProductModel] = []
    static var arrProductData: [ProductModel] = []
    var objProductCategory: ProductModel?
    var arrfilteredProductData: [ProductModel] = []
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        arrrecentItems = RecentItemsHelper.shared.getRecentItems()
        tblView.reloadData()
        filterProducts(with: txtSearch.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set greeting with user name if available
        if let userName = fetchLoggedInUserName() {
            setLeftAlignedTitle("Good morning \(userName)!")
        } else {
            setLeftAlignedTitle("Good morning!")
        }
        
        // Setup UI components
        setCartButton(target: self, action: #selector(btnCartTapped))
        EditStyle.setborder(textfields: [txtSearch])
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 28)
        tblView.showsVerticalScrollIndicator = false
        tblView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        txtSearch.delegate = self
        
        arrfilteredProductData = HomeViewController.arrProductData
        
        // Load saved address from UserDefaults
        if let savedAddress = UserDefaults.standard.string(forKey: "savedAddress") {
            lblAddress.text = savedAddress
        }
        
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
        
        // Fetch product data
        fetchProductDataFromAPI()
    }
    
    // MARK: - Core Data Fetching
    /// Fetch the logged-in user's name from Core Data using `loggedInUserID`.
    private func fetchLoggedInUserName() -> String? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let userIdString = UserDefaults.standard.string(forKey: "loggedInUserID"),
              let userId = UUID(uuidString: userIdString) else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "userID == %@", userId as CVarArg)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if let user = result.first {
                return user.value(forKey: "name") as? String
            }
        } catch {
            print(" Failed to fetch user: \(error.localizedDescription)")
        }
        return nil
    }
    
    // MARK: - API Calls
    /// Fetch product data from API and update Core Data & UI.
    private func fetchProductDataFromAPI() {
        let apiURLString = "https://mocki.io/v1/02f731b0-da61-4bca-8412-88dedb1533cb"
        APICalls.getData(from: apiURLString) { [weak self] (products: [ProductModel]) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if !products.isEmpty {
                    HomeViewController.arrProductData = products
                    self.filterProducts(with: self.txtSearch.text)
                    self.saveProductDataToCoreData(products)
                } else {
                    print("Could not fetch products or received an empty list.")
                    let alert = UIAlertController(title: "Error", message: "Failed to load products. Please try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                self.tblView.reloadData()
                print("Data is comming form api")
            }
        }
    }
    
    // MARK: - Delegate Methods
    /// Called when user selects an address from MapViewController
    func didSelectAddress(_ address: String) {
        lblAddress.text = address
    }
    
    /// Called when Cart button is tapped - navigates to CartViewController
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            secondVC.pagetype = .Cart
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    /// Called when a product is selected from HomeTableViewCell
    func HomeTableViewCell(_ cell: HomeTableViewCell, didSelectProduct product: ProductModel) {
        RecentItemsHelper.shared.addProduct(product)
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ItemDetailsViewController") as? ItemDetailsViewController {
            detailVC.selectedProduct = product
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        arrrecentItems = RecentItemsHelper.shared.getRecentItems()
        tblView.reloadData()
    }
    
    /// Called when a category is selected from HomeTableViewCell
    func HomeTableViewCell(_ cell: HomeTableViewCell, didSelectCategory category: ProductCategory) {
        filterProducts(with: txtSearch.text)
        selectedCategory = category
    }
    
    /// Called when search text field changes
    func textFieldDidChangeSelection(_ textField: UITextField) {
        filterProducts(with: textField.text)
    }
    
    // MARK: - Actions
    @IBAction func btnDropDownClick(_ sender: Any) {
        // TODO: Implement address dropdown logic
    }
    
    // MARK: - Filtering
    /// Filter products based on search text.
    func filterProducts(with searchText: String?) {
        if let text = searchText, !text.isEmpty {
            let lowercaseText = text.lowercased()
            arrfilteredProductData = HomeViewController.arrProductData.filter { product in
                let productNameMatches = product.strProductName.lowercased().contains(lowercaseText)
                let productCategoryMatches = product.objProductCategory.rawValue.lowercased().contains(lowercaseText)
                return productNameMatches || productCategoryMatches
            }
        } else {
            arrfilteredProductData = HomeViewController.arrProductData
        }
        
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
    
    // MARK: - Core Data Saving
    /// Save fetched product data into Core Data after clearing old data.
    private func saveProductDataToCoreData(_ products: [ProductModel]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Delete old product data
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
            print("✅ Successfully cleared old product data from Core Data.")
        } catch let error as NSError {
            print("❌ Failed to clear old product data: \(error), \(error.userInfo)")
            return
        }
        
        // Insert new product data
        for productModel in products {
            guard let productEntity = NSEntityDescription.entity(forEntityName: "Product", in: managedContext) else { continue }
            let product = NSManagedObject(entity: productEntity, insertInto: managedContext)
            
            product.setValue(productModel.objProductCategory.rawValue, forKey: "category")
            product.setValue(productModel.strProductImage, forKey: "imagePath")
            product.setValue(productModel.strProductName, forKey: "name")
            product.setValue(productModel.doubleProductPrice, forKey: "price")
            product.setValue(productModel.strProductDescription, forKey: "productDescription")
            product.setValue(productModel.intId, forKey: "productID")
            product.setValue(productModel.objProductType.rawValue, forKey: "productType")
            product.setValue(productModel.floatProductRating, forKey: "rating")
            product.setValue(productModel.intTotalNumberOfRatings, forKey: "totalRatings")
        }
        
        do {
            try managedContext.save()
            print("✅ Successfully saved all new API product data to Core Data.")
        } catch let error as NSError {
            print("❌ Could not save new product data. \(error), \(error.userInfo)")
        }
    }
}
