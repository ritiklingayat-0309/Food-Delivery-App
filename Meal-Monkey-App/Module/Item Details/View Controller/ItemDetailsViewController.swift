//
//  ItemDetailsViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 09/08/25.
//

import UIKit

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
    
    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
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
    
    private func checkWishlistStatus() {//mmmm
        guard let appDelegate = appDelegate,
              let product = selectedProduct else { return }
        
        if appDelegate.arrWishlist.contains(where: { $0.intId == product.intId }) {
            isHeartFilled = true
            btnHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            isHeartFilled = false
            btnHeart.setImage(UIImage(systemName: "heart"), for: .normal)
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
    
    @IBAction func btnHeartAction(_ sender: UIButton) {//mmmmmm
        guard let appDelegate = appDelegate,
              let product = selectedProduct else { return }
        
        isHeartFilled.toggle()
        if isHeartFilled {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            if !appDelegate.arrWishlist.contains(where: { $0.intId == product.intId }) {
                appDelegate.arrWishlist.append(product)
                print("Added to wishlist")
            }
        } else {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            if let index = appDelegate.arrWishlist.firstIndex(where: { $0.intId == product.intId }) {
                appDelegate.arrWishlist.remove(at: index)
                print("Removed from wishlist")
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
        print("add too cart from detail Page")
        guard let product = selectedProduct else {
            print("Error: No product selected to add to cart.")
            return
        }
        checkProduct(productToAdd: product)
        let alert = UIAlertController(title: "Success", message: "Added to cart!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func checkProduct(productToAdd: ProductModel) {
        guard let appDelegate = appDelegate else { return }
        if let existingIndex = appDelegate.arrCart.firstIndex(where: { $0.intId == productToAdd.intId }) {
            appDelegate.arrCart[existingIndex].intProductQty! += currentQuantity
        } else {
            let newProduct = productToAdd
            newProduct.intProductQty = currentQuantity
            appDelegate.arrCart.append(newProduct)
            
        }
        for product in appDelegate.arrCart {
            print("🛒 Cart Product:")
            print("ID: \(product.intId)")
            print("image: \(product.strProductImage)")
            print("category: \(product.objProductCategory.rawValue)")
            print("Name: \(product.strProductName)")
            print("Qty: \(product.intProductQty)")
            print("Category: \(product.objProductCategory.rawValue)")
            print("---------")
        }
    }
}
