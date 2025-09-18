//
//  MyOrderViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 08/08/25.
//

import UIKit

/// ViewController responsible for displaying the user's current order,
/// including ordered items, subtotal, delivery cost, and total.
/// Provides checkout navigation and option to add notes.
class MyOrderViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var lglDelveryInstructions: UILabel!
    @IBOutlet weak var lbllocSubTotal: UILabel!
    @IBOutlet weak var lbllocDeliveryCost: UILabel!
    @IBOutlet weak var lbllocTotal: UILabel!
    @IBOutlet weak var lbllocKingBurger: UILabel!
    @IBOutlet weak var lblfourPointFive: UILabel!
    @IBOutlet weak var lbllocRating: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnAddNote: UIButton!  // Button to add special note for the order
    @IBOutlet weak var lblSubTotal: UILabel!  // Label showing subtotal of ordered items
    @IBOutlet weak var btnCheckout: UIButton!  // Button to proceed to checkout
    @IBOutlet weak var lblTotal: UILabel!  // Label showing total including delivery cost
    @IBOutlet weak var lblDeliveryCost: UILabel!  // Label showing delivery charges
    @IBOutlet weak var tblView: UITableView!  // TableView to display ordered items

    // MARK: - Properties
    var orderProducts: [ProductModel] = []  // Array of ordered products (if needed for display)
    let deliveryCost: Double = 5.0  // Fixed delivery cost
    var selectedOrder: Order!  // The current selected order (from Core Data)
    var orderedItems: [OrderedItem] = []  // List of ordered items fetched from Core Data

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set navigation title with back button
        setLeftAlignedTitleWithBack(
            LocalizationManager.shared.localizedString(
                forKey: Main.MyOrder.myOrdernav
            ),
            target: self,
            action: #selector(backButtonTapped)
        )

        // Register custom cell for tableview
        tblView.register(
            UINib(
                nibName: Main.CellIdentifier.MyOrderTableViewCell,
                bundle: nil
            ),
            forCellReuseIdentifier: Main.CellIdentifier.MyOrderTableViewCell
        )

        // Apply border styling on checkout button
        EditStyle.setborder(textfields: [btnCheckout])

        // hide scroll indicator
        tblView.showsVerticalScrollIndicator = false

        // Load ordered items and refresh UI
        fetchOrderedItems()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )

        // Apply theme initially
        applyTheme()
    }

    @objc func applyTheme() {
        let theme = ThemeManager.currentTheme

        // MARK: - Backgrounds
        view.backgroundColor = theme.backgroundColor
        tblView.backgroundColor = theme.backgroundColor

        // MARK: - Labels
        lblTotal.textColor = theme.primaryFontColor
        lblSubTotal.textColor = theme.primaryFontColor
        lblDeliveryCost.textColor = theme.primaryFontColor

        lblTotal.textColor = theme.secondaryFontColor
        lblSubTotal.textColor = theme.secondaryFontColor
        lblDeliveryCost.textColor = theme.secondaryFontColor
        lblAddress.textColor = theme.primaryFontColor
        lbllocKingBurger
            .textColor = theme.primaryFontColor
        lglDelveryInstructions.textColor = theme.secondaryFontColor

        // MARK: - Buttons
        btnCheckout.backgroundColor = theme.mainColor
        btnCheckout.setTitleColor(theme.buttonTitle, for: .normal)
        btnAddNote.setTitleColor(theme.buttonColor, for: .normal)

        // MARK: - Reload TableView to update cell colors
        tblView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateAllUI()

        // Observe language changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(languageDidChange),
            name: .languageChanged,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func languageDidChange() {
        updateAllUI()
    }

    private func updateAllUI() {
        // Navigation title
        setLeftAlignedTitleWithBack(
            LocalizationManager.shared.localizedString(
                forKey: Main.MyOrder.myOrdernav
            ),
            target: self,
            action: #selector(backButtonTapped)
        )

        // Labels
        lglDelveryInstructions.text = LocalizationManager.shared
            .localizedString(forKey: Main.MyOrder.deliveryinstruction)
        lbllocSubTotal.text = LocalizationManager.shared.localizedString(
            forKey: Main.MyOrder.subtotal
        )
        lbllocDeliveryCost.text = LocalizationManager.shared.localizedString(
            forKey: Main.MyOrder.deliveryCost
        )
        lbllocTotal.text = LocalizationManager.shared.localizedString(
            forKey: Main.MyOrder.total
        )
        lbllocKingBurger.text = LocalizationManager.shared.localizedString(
            forKey: Main.MyOrder.kingBurger
        )
        lblfourPointFive.text = LocalizationManager.shared.localizedString(
            forKey: Main.MyOrder.fourPointFive
        )
        lbllocRating.text = LocalizationManager.shared.localizedString(
            forKey: Main.MyOrder.rating
        )
        lblAddress.text = LocalizationManager.shared.localizedString(
            forKey: Main.MyOrder.address
        )

        // Buttons
        btnAddNote.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.MyOrder.btnAddNote
            ),
            for: .normal
        )
        btnCheckout.setTitle(
            LocalizationManager.shared.localizedString(
                forKey: Main.MyOrder.btncheckout
            ),
            for: .normal
        )
    }

    // MARK: - Data Fetching
    /// Fetch ordered items from the selected order and reload tableView
    func fetchOrderedItems() {
        guard let itemsSet = selectedOrder.orderedItems as? Set<OrderedItem>
        else {
            return
        }
        orderedItems = Array(itemsSet)

        // Calculate subtotal, delivery, and total
        calculateTotals()

        // Reload table to show items
        tblView.reloadData()
    }

    // MARK: - Calculation
    /// Calculate subtotal, delivery cost, and total and update labels
    func calculateTotals() {
        let subtotal = orderedItems.reduce(0) { total, item in
            let price = item.priceAtTimeOfOrder
            let quantity = item.quantity
            return total + (price * Double(quantity))
        }
        lblSubTotal.text = "$\(String(format: "%.2f", subtotal))"
        lblDeliveryCost.text = "$\(String(format: "%.2f", deliveryCost))"
        lblTotal.text = "$\(String(format: "%.2f", subtotal + deliveryCost))"
    }

    // MARK: - Navigation
    /// Back button action to return to previous screen
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - IBActions
    /// Action when "Add Note" button is tapped
    @IBAction func btnAddNoteAction(_ sender: Any) {
        // Future implementation: add note popup or navigation
    }

    /// Action when "Checkout" button is tapped
    @IBAction func btnCheckoutAction(_ sender: Any) {
        let storyboard = UIStoryboard(
            name: Main.StoryboardIdentifier.MoreStoryboard,
            bundle: nil
        )

        if let secondVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllerIdentifier.CheckOutViewController
        ) as? CheckOutViewController {

            // Calculate subtotal and total before passing
            let subtotal = orderedItems.reduce(0.0) { total, item in
                let price = item.priceAtTimeOfOrder
                let quantity = item.quantity
                return total + (price * Double(quantity))
            }
            let total = subtotal + deliveryCost

            // Pass values to checkout VC
            secondVc.subtotal = subtotal
            secondVc.deliveryCost = deliveryCost
            secondVc.total = total

            // Navigate to checkout screen
            self.navigationController?.pushViewController(
                secondVc,
                animated: true
            )
        }
    }
}
