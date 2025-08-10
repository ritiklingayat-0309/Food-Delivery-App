//
//  ItemDetailsViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 09/08/25.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    //for hold selected data
    var selectedProduct: ProductModel?
    // Add a property to store the current quantity.
    var currentQuantity: Int = 1
    @IBOutlet weak var imgViewItem: UIImageView!
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
    // A quick way to get the app delegate.
    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    // Create a new function to set up the UI based on the selected product.
        func configureUI() {
            guard let product = selectedProduct else { return }
            self.title = product.strProductName
            // Set the UI elements using the product's properties.
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
            Qtylbl.text = "\(currentQuantity)" // Update the quantity label
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
        let storyboard = UIStoryboard(name: "MenuListStoryboard", bundle: nil) // Change if different
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            navigationController?.pushViewController(secondVC, animated: true)
        }
        
    }
    
    @IBAction func btnAddToCartAction(_ sender: Any) {
        // 1. First, safely unwrap the selectedProduct property.
        print("add too cart from detail Page")
            guard let product = selectedProduct else {
                // Handle the case where no product is selected, perhaps by showing an error.
                print("Error: No product selected to add to cart.")
                return
            }

            // 2. Call the checkProduct function, passing the unwrapped product.
            // The name of the parameter `productToAdd` is internal to the function,
            // so you just need to pass the correct value here.
            checkProduct(productToAdd: product)
            
            // Show a success alert.
            let alert = UIAlertController(title: "Success", message: "Added to cart!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
    }
    
    func checkProduct(productToAdd: ProductModel) {
           guard let appDelegate = appDelegate else { return }
           
           // Find if the product already exists in the cart.
           if let existingIndex = appDelegate.arrCart.firstIndex(where: { $0.intId == productToAdd.intId }) {
               // If it exists, update its quantity and total price.
               appDelegate.arrCart[existingIndex].intProductQty = currentQuantity
               print("Updated \(productToAdd.strProductName) quantity to \(currentQuantity).")
           } else {
               // If it's a new product, set its quantity and add it to the cart.
               let newProduct = productToAdd
               newProduct.intProductQty = currentQuantity
               appDelegate.arrCart.append(newProduct)
               print("Added \(productToAdd.strProductName) with quantity \(currentQuantity).")
           }
       }
    
}
