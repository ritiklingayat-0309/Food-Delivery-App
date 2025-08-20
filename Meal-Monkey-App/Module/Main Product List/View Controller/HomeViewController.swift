//
//  HomeViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 11/08/25.
//

import UIKit
import CoreData
import UserNotifications

/// The main home screen controller responsible for displaying categories, recent items,
/// product list, and handling search & address selection.
class HomeViewController: UIViewController, HomeTableTableViewCellDelegate, UITextFieldDelegate, MapViewControllerDelegate,UNUserNotificationCenterDelegate{
    
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
        
        // Load saved address and call delegate method
        if let savedAddress = UserDefaults.standard.string(forKey: "savedAddress") {
            didSelectAddress(savedAddress)
        }
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
        
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
        
        // Fetch product data
        fetchProductDataFromAPI()
        
        // 🔔 Ask for Notification Permission when Home loads
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("✅ Notification permission granted")
                UNUserNotificationCenter.current().delegate = self
                self.scheduleMultipleNotifications() // 🔔 Send 5 notifications automatically
            } else {
                print("❌ Permission denied")
            }
        }
    }
    
    private func scheduleMultipleNotifications() {
        let messages = [
            "📢 Notification 1: Welcome to Meal Monkey!",
            "🔥 Notification 2: Don't miss today’s offers.",
            "⭐️ Notification 3: Try our top-rated dishes!",
            "🚀 Notification 4: Hungry? Order now!",
            "✅ Notification 5: Thank you for using our app!"
        ]
        
        for (index, message) in messages.enumerated() {
            let content = UNMutableNotificationContent()
            content.title = "Meal Monkey 🍔"
            content.body = message
            content.sound = .default
            content.badge = NSNumber(value: index + 1)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval((index + 1) * 3), repeats: false)
            
            let request = UNNotificationRequest(
                identifier: "mealMonkeyNotification\(index)",
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("⚠️ Error scheduling notification \(index + 1): \(error)")
                } else {
                    print("✅ Scheduled notification \(index + 1) after \((index + 1) * 3) sec")
                }
            }
        }
    }
    
    // 🔔 Show notification even in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    // 🔔 Handle notification tap
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("📩 User tapped: \(response.notification.request.identifier)")
        completionHandler()
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
    
    // MARK: - Core Data Saving (CHANGED ✅)
    /// Save fetched product data into Core Data after checking duplicates by productID.
    private func saveProductDataToCoreData(_ products: [ProductModel]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        for productModel in products {
            // ✅ Check if product already exists in Core Data
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Product")
            fetchRequest.predicate = NSPredicate(format: "productID == %d", productModel.intId)
            
            do {
                let existingProducts = try managedContext.fetch(fetchRequest)
                if existingProducts.isEmpty {
                    // Only insert if product does NOT exist
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
                    print("✅ Added new product: \(productModel.strProductName)")
                } else {
                    print("⏩ Skipped duplicate product: \(productModel.strProductName)")
                }
            } catch {
                print("❌ Error checking product existence: \(error.localizedDescription)")
            }
        }
        
        do {
            try managedContext.save()
            print("✅ Successfully saved new products to Core Data (duplicates skipped).")
        } catch let error as NSError {
            print("❌ Could not save new product data. \(error), \(error.userInfo)")
        }
    }
}
