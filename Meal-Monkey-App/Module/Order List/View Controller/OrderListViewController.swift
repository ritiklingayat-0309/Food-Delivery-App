//
//  OrderListViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import UIKit
import CoreData

/// `OrderListViewController`
///
/// This view controller is responsible for displaying the list of orders placed
/// by the currently logged-in user.
/// - Uses **Core Data** to fetch orders filtered by `loggedInUserID`.
/// - Shows an empty label if no orders are available.
/// - Displays order data inside a table view when available.
class OrderListViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// Label shown when no orders are available.
    @IBOutlet weak var lblOrderListEmpt: UILabel!
    
    /// Table view used to display the list of orders.
    @IBOutlet weak var tblView: UITableView!
    
    // MARK: - Properties
    
    /// Stores the list of fetched orders for the logged-in user.
    var arrOrders: [Order] = []
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Set navigation title with a back button.
        setLeftAlignedTitleWithBack("Order List", target: self, action: #selector(backButtonTapped))
        
        /// Register custom table view cell.
        tblView.register(UINib(nibName: "OrderListTableViewCell", bundle: nil),
                         forCellReuseIdentifier: "OrderListTableViewCell")
        
        /// Hide vertical scroll indicator for cleaner UI.
        tblView.showsVerticalScrollIndicator = false
        
        /// Fetch orders from Core Data when view loads.
        fetchOrdersFromCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// Refresh UI whenever the view appears.
        updateUI()
    }
    
    // MARK: - UI Handling
    
    /// Updates the visibility of the label and table view depending on
    /// whether any orders exist.
    private func updateUI() {
        if arrOrders.isEmpty {
            lblOrderListEmpt.isHidden = false
            tblView.isHidden = true
        } else {
            lblOrderListEmpt.isHidden = true
            tblView.isHidden = false
            tblView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    /// Action for back button — pops the current view controller.
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Core Data
    
    /// Fetches orders for the currently logged-in user from Core Data.
    ///
    /// - Retrieves `loggedInUserID` from `UserDefaults`.
    /// - Filters orders by matching `userID`.
    /// - Sorts by `orderDate` in descending order.
    /// - Prefetches `orderedItems` and related `product` data for optimization.
    private func fetchOrdersFromCoreData() {
        guard let savedUserIDString = UserDefaults.standard.string(forKey: "loggedInUserID"),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            self.arrOrders = []
            self.updateUI()
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Order>(entityName: "Order")
        
        /// Convert saved user ID string into UUID.
        guard let savedUserID = UUID(uuidString: savedUserIDString) else {
            self.arrOrders = []
            self.updateUI()
            return
        }
        
        /// Predicate ensures only orders of the logged-in user are fetched.
        let predicate = NSPredicate(format: "userID == %@", savedUserID as CVarArg)
        fetchRequest.predicate = predicate
        
        /// Prefetch relationships to avoid multiple fetches while displaying.
        fetchRequest.relationshipKeyPathsForPrefetching = ["orderedItems", "orderedItems.product"]
        
        /// Sort orders by order date (latest first).
        let sortDescriptor = NSSortDescriptor(key: "orderDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            /// Perform fetch and update UI.
            self.arrOrders = try managedContext.fetch(fetchRequest)
            self.updateUI()
        } catch {
            print("Failed to fetch orders: \(error.localizedDescription)")
            self.arrOrders = []
            self.updateUI()
        }
    }
}
