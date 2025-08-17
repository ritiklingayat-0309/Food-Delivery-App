//
//  ItemDetailsViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 09/08/25.
//

import UIKit
import CoreData

class ItemDetailsViewController: UIViewController {
    var selectedProduct: ProductModel?
    var currentQuantity: Int = 1
    var isHeartFilled = false
    @IBOutlet weak var imgViewItem: UIImageView!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var viewCountPlus_Minus: UIView!
    @IBOutlet weak var Qtylbl: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var scrollViewDetails: UIScrollView!
    @IBOutlet weak var btnTrolly: UIButton!
    @IBOutlet weak var viewDetailPage: UIView!
    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var activityIndictor: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewDetails.showsVerticalScrollIndicator = false
        self.setCartButton(target: self, action: #selector(cartButtonTapped))
        setLeftAlignedTitleWithBack("Food Detail",target: self,action: #selector(backButtonTapped))
        btnPlus.layer.cornerRadius = btnPlus.frame.height/2
        btnMinus.layer.cornerRadius = btnMinus.frame.height/2
        btnAddToCart.layer.cornerRadius = btnAddToCart.frame.height/2
        viewCountPlus_Minus.layer.cornerRadius = viewCountPlus_Minus.frame.height/2
        viewCountPlus_Minus.layer.borderColor = UIColor(red: 252/255, green: 96/255, blue: 17/255, alpha: 1.0).cgColor
        viewCountPlus_Minus.layer.borderWidth = 1.0
        viewCountPlus_Minus.clipsToBounds = true
        configureUI()
        currentQuantity = 1
        scrollViewDetails.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 200)
        navigationController?.navigationItem.hidesBackButton = true
        viewDetailPage.layer.cornerRadius = 42
        viewDetailPage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewDetailPage.clipsToBounds = true
        viewDetailPage.layer.borderWidth = 2
        viewDetailPage.layer.borderColor = UIColor.gray.cgColor
        hideUIElementsForLoading()
        activityIndictor.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.activityIndictor.stopAnimating()
            self.showUIElementsAfterLoading()
            self.configureUI()
            self.checkWishlistStatus()
            self.checkWishlistStatus()
            self.activityIndictor.isHidden = true
        }
    }
    
    private func hideUIElementsForLoading() {
        viewDetails.isHidden = true
        btnHeart.isHidden = true
        imgViewItem.isHidden = true
    }
    
    private func showUIElementsAfterLoading() {
        viewDetails.isHidden = false
        btnHeart.isHidden = false
        imgViewItem.isHidden = false
    }
    
    private func checkWishlistStatus() {
        guard let savedUserIDString = UserDefaults.standard.string(forKey: "loggedInUserID"),
              let product = selectedProduct,
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Wishlist")
        
        // Predicate to find if the product exists in the current user's wishlist
        let predicate = NSPredicate(format: "productID == %i AND userID == %@", product.intId, savedUserIDString)
        fetchRequest.predicate = predicate
        
        do {
            let wishlistItems = try managedContext.fetch(fetchRequest)
            if !wishlistItems.isEmpty {
                isHeartFilled = true
                btnHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                isHeartFilled = false
                btnHeart.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        } catch {
            print("Failed to fetch wishlist status: \(error.localizedDescription)")
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cartButtonTapped() {
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secdVc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            secdVc.pagetype = .Cart
            navigationController?.pushViewController(secdVc, animated: true)
        }
    }
    
    func configureUI() {
        guard let product = selectedProduct else { return }
        lblItemName.text = product.strProductName
        lblDescription.text = product.strProductDescription
        imgViewItem.image = UIImage(named: product.strProductImage)
        lblRating.text = "\(product.floatProductRating) (\(product.intTotalNumberOfRatings) ratings)"
        updatePriceAndQuantityUI()
    }
    
    func updatePriceAndQuantityUI() {
        guard let product = selectedProduct else { return }
        let total = product.doubleProductPrice * Double(currentQuantity)
        lblPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice))"
        lblTotalPrice.text = "$\(String(format: "%.2f", total))"
        Qtylbl.text = "\(currentQuantity)"
        if currentQuantity == 1 {
            btnMinus.isEnabled = false
            btnMinus.alpha = 0.5
        } else {
            btnMinus.isEnabled = true
            btnMinus.alpha = 1.0
        }
    }
    
    @IBAction func btnHeartAction(_ sender: UIButton) {
        guard let savedUserIDString = UserDefaults.standard.string(forKey: "loggedInUserID"),
              let savedUserID = UUID(uuidString: savedUserIDString),
              let product = selectedProduct,
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if isHeartFilled {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Wishlist")
            let predicate = NSPredicate(format: "productID == %i AND userID == %@", product.intId, savedUserID as CVarArg)
            fetchRequest.predicate = predicate
            
            do {
                let result = try managedContext.fetch(fetchRequest)
                for object in result {
                    managedContext.delete(object)
                }
                try managedContext.save()
                isHeartFilled = false
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
                print("Removed from Core Data wishlist")
            } catch {
                print("Failed to remove from wishlist: \(error.localizedDescription)")
            }
        } else {
            guard let wishlistEntity = NSEntityDescription.entity(forEntityName: "Wishlist", in: managedContext) else { return }
            let wishlistItem = NSManagedObject(entity: wishlistEntity, insertInto: managedContext)
            
            wishlistItem.setValue(product.intId, forKey: "productID")
            wishlistItem.setValue(savedUserID, forKey: "userID")
            
            do {
                try managedContext.save()
                isHeartFilled = true
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                print("Added to Core Data wishlist")
            } catch {
                print("Failed to add to wishlist: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func btnMinusAction(_ sender: Any) {
        if currentQuantity > 1 {
            currentQuantity -= 1
            updatePriceAndQuantityUI()
        }
    }
    
    @IBAction func btnPlusAction(_ sender: Any) {
        currentQuantity += 1
        updatePriceAndQuantityUI()
    }
    
    @IBAction func btnTrollyAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            secondVC.pagetype = .Cart
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    @IBAction func btnAddToCartAction(_ sender: Any) {
        print("add to cart from detail Page")
        guard let product = selectedProduct else {
            print("Error: No product selected to add to cart.")
            return
        }
        
        // Add the product to the Core Data cart
        addToCart(productToAdd: product)
        
        let alert = UIAlertController(title: "Success", message: "Added to cart!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func addToCart(productToAdd: ProductModel) {
        guard let savedUserIDString = UserDefaults.standard.string(forKey: "loggedInUserID"),
              let savedUserID = UUID(uuidString: savedUserIDString),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cart")
        let predicate = NSPredicate(format: "productID == %i AND userID == %@", productToAdd.intId, savedUserID as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let existingCartItems = try managedContext.fetch(fetchRequest)
            
            if let existingCartItem = existingCartItems.first {
                let newQuantity = (existingCartItem.value(forKey: "quantity") as? Int ?? 0) + currentQuantity
                existingCartItem.setValue(newQuantity, forKey: "quantity")
                print("Product \(productToAdd.strProductName) updated in cart. New quantity: \(newQuantity)")
            } else {
                guard let cartEntity = NSEntityDescription.entity(forEntityName: "Cart", in: managedContext) else { return }
                let newCartItem = NSManagedObject(entity: cartEntity, insertInto: managedContext)
                newCartItem.setValue(productToAdd.intId, forKey: "productID")
                newCartItem.setValue(currentQuantity, forKey: "quantity")
                newCartItem.setValue(savedUserID, forKey: "userID")
                print("Product \(productToAdd.strProductName) added to cart with quantity: \(currentQuantity)")
            }
            
            try managedContext.save()
            print("Cart data saved successfully to Core Data.")
        } catch {
            print("Failed to save cart data: \(error.localizedDescription)")
        }
    }
}
