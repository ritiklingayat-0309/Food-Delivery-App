//
//  CartViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 10/08/25.
//

import CoreData
import Lottie
import UIKit

/// Controller to display Cart or Wishlist items
class CartViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    private var emptyAnimationView: LottieAnimationView?
    private var emptyLabel: UILabel?

    // MARK: - Properties
    var pagetype: PageType = .Wishlist  // Determines if controller shows Cart or Wishlist
    var arritemsToShow: [ProductModel] = []  // Items to display in table

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchItemsFromCoreData()

        // Set navigation title based on page type
        if pagetype == .Wishlist {
            setLeftAlignedTitleWithBack(
                LocalizationManager.shared.localizedString(
                    forKey: Main.Cart.navWish
                ),
                target: self,
                action: #selector(backButtonTapped)
            )
        } else {
            setLeftAlignedTitleWithBack(
                LocalizationManager.shared.localizedString(
                    forKey: Main.Cart.navcart
                ),
                target: self,
                action: #selector(backButtonTapped)
            )
        }

        // Set button title
        btnPlaceOrder.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.Cart.btnPlacedOrder
            ),
            for: .normal
        )

        tblView.reloadData()
        updateAllUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register table view cell
        tblView.register(
            UINib(nibName: Main.CellIdentifier.CartTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifier.CartTableViewCell
        )

        // Style button
        EditStyle.setborder(textfields: [btnPlaceOrder])
        setupEmptyAnimation()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(languageDidChange),
            name: .languageChanged,
            object: nil
        )

        //for theam
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: Notification.Name("themeChanged"),
            object: nil
        )
        applyTheme()

    }

    @objc private func applyTheme() {
        let theme = ThemeManager.currentTheme
        btnPlaceOrder.backgroundColor = theme.buttonColor
        btnPlaceOrder.setTitleColor(theme.buttonTitle, for: .normal)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func languageDidChange() {
        updateAllUI()
    }

    private func updateAllUI() {
        // Navigation title
        let titleKey =
            (pagetype == .Wishlist) ? Main.Cart.navWish : Main.Cart.navcart
        setLeftAlignedTitleWithBack(
            LocalizationManager.shared.localizedString(forKey: titleKey),
            target: self,
            action: #selector(backButtonTapped)
        )

        // Button title
        btnPlaceOrder.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.Cart.btnPlacedOrder
            ),
            for: .normal
        )

        // Empty label text
        emptyLabel?.text =
            (pagetype == .Wishlist)
            ? LocalizationManager.shared.localizedString(
                forKey: Main.EmptyLabel.emptyWishlist
            )
            : LocalizationManager.shared.localizedString(
                forKey: Main.EmptyLabel.emptyCart
            )

        updateUI()
    }

    // MARK: - Setup Empty Animation
    private func setupEmptyAnimation() {
        // Select animation based on page type
        let animationFile =
            (pagetype == .Wishlist) ? "Flying heart" : "Empty box"

        emptyAnimationView = LottieAnimationView(name: animationFile)
        if let emptyAnimationView = emptyAnimationView {
            emptyAnimationView.contentMode = .scaleAspectFit
            emptyAnimationView.loopMode = .loop
            emptyAnimationView.isHidden = true
            emptyAnimationView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(emptyAnimationView)

            NSLayoutConstraint.activate([
                emptyAnimationView.centerXAnchor.constraint(
                    equalTo: view.centerXAnchor
                ),
                emptyAnimationView.centerYAnchor.constraint(
                    equalTo: view.centerYAnchor,
                    constant: -50
                ),
                emptyAnimationView.widthAnchor.constraint(
                    equalTo: view.widthAnchor,
                    multiplier: 0.6
                ),
                emptyAnimationView.heightAnchor.constraint(
                    equalToConstant: 250
                ),
            ])

            //  Add label below animation
            let label = UILabel()
            label.text =
                (pagetype == .Wishlist)
                ? LocalizationManager.shared.localizedString(
                    forKey: Main.EmptyLabel.emptyWishlist
                )
                : LocalizationManager.shared.localizedString(
                    forKey: Main.EmptyLabel.emptyCart
                )
            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            label.textColor = .darkGray
            label.textAlignment = .center
            label.isHidden = true
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)

            NSLayoutConstraint.activate([
                label.topAnchor.constraint(
                    equalTo: emptyAnimationView.bottomAnchor,
                    constant: 12
                ),
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])

            // Store reference so we can show/hide later
            emptyLabel = label
        }
    }

    // MARK: - Navigation
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - UI Updates
    /// Shows/hides table view, empty message and place order button based on items
    func updateUI() {
        if arritemsToShow.isEmpty {
            tblView.isHidden = true
            btnPlaceOrder.isHidden = true
            emptyAnimationView?.isHidden = false
            emptyAnimationView?.play()

            // Show label
            emptyLabel?.isHidden = false
            //            emptyLabel?.text = (pagetype == .Wishlist) ? Main.EmptyLabel.emptyWishlist : Main.EmptyLabel.emptyCart
        } else {
            tblView.isHidden = false
            btnPlaceOrder.isHidden = (pagetype == .Wishlist)
            btnPlaceOrder.alpha = (pagetype == .Wishlist) ? 0.0 : 1.0

            tblView.reloadData()

            emptyAnimationView?.stop()
            emptyAnimationView?.isHidden = true

            // Hide label
            emptyLabel?.isHidden = true
        }
    }

    // MARK: - Core Data
    /// Fetches items from Core Data based on `pagetype` (Wishlist/Cart) and logged-in user
    private func fetchItemsFromCoreData() {
        guard
            let savedUserIDString = UserDefaults.standard.string(
                forKey: "loggedInUserID"
            ),
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            self.arritemsToShow = []
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let entityName = (pagetype == .Wishlist) ? "Wishlist" : "Cart"
        let fetchRequest = NSFetchRequest<NSManagedObject>(
            entityName: entityName
        )
        fetchRequest.predicate = NSPredicate(
            format: "userID == %@",
            savedUserIDString
        )

        do {
            let fetchedItems = try managedContext.fetch(fetchRequest)
            var products: [ProductModel] = []

            for item in fetchedItems {
                if let productID = item.value(forKey: "productID") as? Int {
                    let productFetchRequest = NSFetchRequest<NSManagedObject>(
                        entityName: "Product"
                    )
                    productFetchRequest.predicate = NSPredicate(
                        format: "productID == %i",
                        productID
                    )

                    if let productData = try managedContext.fetch(
                        productFetchRequest
                    ).first,
                        let productName = productData.value(forKey: "name")
                            as? String,
                        let productPrice = productData.value(forKey: "price")
                            as? Double,
                        let productImage = productData.value(
                            forKey: "imagePath"
                        ) as? String,
                        let productDescription = productData.value(
                            forKey: "productDescription"
                        ) as? String,
                        let productRating = productData.value(forKey: "rating")
                            as? Float,
                        let totalRatings = productData.value(
                            forKey: "totalRatings"
                        ) as? Int,
                        let productCategoryString = productData.value(
                            forKey: "category"
                        ) as? String,
                        let productCategory = ProductCategory(
                            rawValue: productCategoryString
                        ),
                        let productTypeString = productData.value(
                            forKey: "productType"
                        ) as? String,
                        let productType = ProductType(
                            rawValue: productTypeString
                        )
                    {

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
                            product.intProductQty =
                                item.value(forKey: "quantity") as? Int ?? 1
                        }
                        products.append(product)
                    }
                }
            }
            self.arritemsToShow = products
        } catch {
            print(
                "Failed to fetch items from Core Data: \(error.localizedDescription)"
            )
            self.arritemsToShow = []
        }
    }

    /// Removes item from Core Data (Cart or Wishlist)
    func removeItemFromCoreData(at indexPath: IndexPath) {
        guard
            let savedUserIDString = UserDefaults.standard.string(
                forKey: "loggedInUserID"
            ),
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let product = arritemsToShow[safe: indexPath.row]
        else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let entityName = (pagetype == .Wishlist) ? "Wishlist" : "Cart"
        let fetchRequest = NSFetchRequest<NSManagedObject>(
            entityName: entityName
        )
        fetchRequest.predicate = NSPredicate(
            format: "productID == %i AND userID == %@",
            product.intId,
            savedUserIDString
        )

        do {
            let result = try managedContext.fetch(fetchRequest)
            if let objectToDelete = result.first {
                managedContext.delete(objectToDelete)
                try managedContext.save()
                print(
                    "Successfully removed item from Core Data: \(product.strProductName)"
                )
                fetchItemsFromCoreData()
                updateUI()
            }
        } catch {
            print(
                "Failed to remove item from Core Data: \(error.localizedDescription)"
            )
        }
    }

    // MARK: - Actions
    /// Handles the "Place Order" button action
    @IBAction func btnPlaceOrderAction(_ sender: Any) {
        guard
            let savedUserIDString = UserDefaults.standard.string(
                forKey: "loggedInUserID"
            ),
            let savedUserID = UUID(uuidString: savedUserIDString),
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            return
        }

        // Do not place order for wishlist
        if pagetype == .Wishlist { return }

        let managedContext = appDelegate.persistentContainer.viewContext
        let cartFetchRequest = NSFetchRequest<NSManagedObject>(
            entityName: "Cart"
        )
        cartFetchRequest.predicate = NSPredicate(
            format: "userID == %@",
            savedUserIDString
        )

        do {
            let cartItems = try managedContext.fetch(cartFetchRequest)

            if cartItems.isEmpty {
                UIAlertController.showAlert(
                    title: Main.AlertTitle.emptyCart,
                    message: Main.AlertMessage.addItemBeforPlaced,
                    viewController: self
                )
                return
            }

            guard
                let orderEntity = NSEntityDescription.entity(
                    forEntityName: "Order",
                    in: managedContext
                )
            else { return }
            let newOrder =
                NSManagedObject(entity: orderEntity, insertInto: managedContext)
                as! Order
            var totalOrderAmount: Double = 0.0
            guard
                let orderedItemEntity = NSEntityDescription.entity(
                    forEntityName: "OrderedItem",
                    in: managedContext
                )
            else { return }

            for cartItem in cartItems {
                guard
                    let productID = cartItem.value(forKey: "productID") as? Int,
                    let quantity = cartItem.value(forKey: "quantity") as? Int
                else { continue }

                let productFetchRequest = NSFetchRequest<NSManagedObject>(
                    entityName: "Product"
                )
                productFetchRequest.predicate = NSPredicate(
                    format: "productID == %i",
                    productID
                )
                guard
                    let product = try managedContext.fetch(productFetchRequest)
                        .first,
                    let price = product.value(forKey: "price") as? Double
                else { continue }

                let newOrderedItem =
                    NSManagedObject(
                        entity: orderedItemEntity,
                        insertInto: managedContext
                    ) as! OrderedItem
                newOrderedItem.setValue(UUID(), forKey: "orderedItemID")
                newOrderedItem.setValue(price, forKey: "priceAtTimeOfOrder")
                newOrderedItem.setValue(quantity, forKey: "quantity")
                newOrderedItem.product = product as? Product
                newOrderedItem.order = newOrder
                totalOrderAmount += price * Double(quantity)
            }

            newOrder.setValue(UUID(), forKey: "orderID")
            newOrder.setValue(savedUserID, forKey: "userID")
            newOrder.setValue(Date(), forKey: "orderDate")
            newOrder.setValue(totalOrderAmount, forKey: "totalAmount")
            try managedContext.save()
            print("Order created successfully with \(cartItems.count) items.")

            // Clear cart
            for cartItem in cartItems {
                managedContext.delete(cartItem)
            }
            try managedContext.save()
            CartManager.shared.notifyCartUpdated()
            print("Cart cleared successfully.")

            fetchItemsFromCoreData()
            updateUI()
            self.showAlert(
                titleKey: Main.AlertTitle.orderPlaced,
                messageKey: Main.AlertMessage.orderPlcedSuccess
            )
        } catch {
            print("Failed to place order: \(error.localizedDescription)")
            UIAlertController.showAlert(
                title: Main.AlertTitle.error,
                message: Main.AlertMessage.failedToPlaceOrder,
                viewController: self
            )
        }
    }
}

// MARK: - Safe Collection Access
extension Collection {
    /// Safe subscript to avoid out-of-bounds errors
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
