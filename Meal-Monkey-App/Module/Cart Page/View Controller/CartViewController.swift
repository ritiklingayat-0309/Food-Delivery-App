//
//  CartViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 10/08/25.
//

import UIKit
import CoreData

class CartViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var lblCartisEmpty: UILabel!
    var pagetype : PageType = .Wishlist
    var arritemsToShow: [ProductModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchItemsFromCoreData()
        if pagetype == .Wishlist {
            setLeftAlignedTitleWithBack("WishList", target: self, action: #selector(backButtonTapped))
        } else {
            setLeftAlignedTitleWithBack("Cart", target: self, action: #selector(backButtonTapped))
        }
        tblView.reloadData()
        updateUI()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func updateUI() {
        if arritemsToShow.isEmpty {
            lblCartisEmpty.isHidden = false
            lblCartisEmpty.text = (pagetype == .Wishlist) ? "Your wishlist is empty." : "Your cart is empty."
            tblView.isHidden = true
            btnPlaceOrder.isHidden = true
        } else {
            lblCartisEmpty.isHidden = true
            tblView.isHidden = false
            // Hide the Place Order button for the wishlist
            btnPlaceOrder.isHidden = (pagetype == .Wishlist)
            btnPlaceOrder.alpha = (pagetype == .Wishlist) ? 0.0 : 1.0
            tblView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "CartTableViewCell", bundle: nil ), forCellReuseIdentifier: "CartTableViewCell")
        EditStyle.setborder(textfields: [btnPlaceOrder])
    }
    
    private func fetchItemsFromCoreData() {
        guard let savedUserIDString = UserDefaults.standard.string(forKey: "loggedInUserID"),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            self.arritemsToShow = []
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entityName = (pagetype == .Wishlist) ? "Wishlist" : "Cart"
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        let predicate = NSPredicate(format: "userID == %@", savedUserIDString)
        fetchRequest.predicate = predicate
        
        do {
            let fetchedItems = try managedContext.fetch(fetchRequest)
            var products: [ProductModel] = []
            for item in fetchedItems {
                if let productID = item.value(forKey: "productID") as? Int {
                    let productFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Product")
                    productFetchRequest.predicate = NSPredicate(format: "productID == %i", productID)
                    
                    if let productData = try managedContext.fetch(productFetchRequest).first,
                       let productName = productData.value(forKey: "name") as? String,
                       let productPrice = productData.value(forKey: "price") as? Double,
                       let productImage = productData.value(forKey: "imagePath") as? String,
                       let productDescription = productData.value(forKey: "productDescription") as? String,
                       let productRating = productData.value(forKey: "rating") as? Float,
                       let totalRatings = productData.value(forKey: "totalRatings") as? Int,
                       let productCategoryString = productData.value(forKey: "category") as? String,
                       let productCategory = ProductCategory(rawValue: productCategoryString),
                       let productTypeString = productData.value(forKey: "productType") as? String,
                       let productType = ProductType(rawValue: productTypeString) {
                        
                        var product = ProductModel(
                            intId: productID,
                            strProductName: productName,
                            strProductDescription: productDescription,
                            floatProductRating: productRating,
                            doubleProductPrice: productPrice,
                            strProductImage: productImage,
                            intTotalNumberOfRatings: totalRatings,
                            objProductCategory: productCategory,
                            objProductType: productType
                        )
                        
                        if pagetype == .Cart {
                            product.intProductQty = item.value(forKey: "quantity") as? Int ?? 1
                        }
                        
                        products.append(product)
                    }
                }
            }
            self.arritemsToShow = products
        } catch {
            print("Failed to fetch items from Core Data: \(error.localizedDescription)")
            self.arritemsToShow = []
        }
    }
    
    @IBAction func btnPlaceOrderAction(_ sender: Any) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
//              let savedUserIDString = UserDefaults.standard.string(forKey: "loggedInUserID") else {
//            return
//        }
//        
//        if pagetype == .Wishlist {
//            return
//        }
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cart")
//        fetchRequest.predicate = NSPredicate(format: "userID == %@", savedUserIDString)
//        
//        do {
//            let cartItems = try managedContext.fetch(fetchRequest)
//            
//            if cartItems.isEmpty {
//                UIAlertController.showAlert(title: "Empty Cart", message: "Please add items before placing an order.", viewController: self)
//                return
//            }
//            guard let orderEntity = NSEntityDescription.entity(forEntityName: "Order", in: managedContext) else { return }
//            let newOrder = NSManagedObject(entity: orderEntity, insertInto: managedContext)
//            
//            newOrder.setValue(savedUserIDString, forKey: "userID")
//            newOrder.setValue(Date(), forKey: "orderDate")
//            
//            try managedContext.save()
//            print("Order created successfully.")
//            for cartItem in cartItems {
//                managedContext.delete(cartItem)
//            }
//            try managedContext.save()
//            fetchItemsFromCoreData() // Refresh data source
//            updateUI()
//            
//            UIAlertController.showAlert(title: "Order Placed", message: "Your order has been placed successfully!", viewController: self)
//        } catch {
//            print("Failed to place order: \(error.localizedDescription)")
//            UIAlertController.showAlert(title: "Error", message: "Failed to place order. Please try again.", viewController: self)
//        }
    }
    
    func removeItemFromCoreData(at indexPath: IndexPath) {
        guard let savedUserIDString = UserDefaults.standard.string(forKey: "loggedInUserID"),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let product = arritemsToShow[safe: indexPath.row] else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entityName = (pagetype == .Wishlist) ? "Wishlist" : "Cart"
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        let predicate = NSPredicate(format: "productID == %i AND userID == %@", product.intId, savedUserIDString)
        fetchRequest.predicate = predicate
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if let objectToDelete = result.first {
                managedContext.delete(objectToDelete)
                try managedContext.save()
                print("✅ Successfully removed item from Core Data: \(product.strProductName)")
                fetchItemsFromCoreData()
            }
        } catch {
            print("❌ Failed to remove item from Core Data: \(error.localizedDescription)")
        }
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}






