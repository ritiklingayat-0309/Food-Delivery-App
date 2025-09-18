//
//  OrderListViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 12/08/25.
//

import CoreData
import Lottie
import UIKit

/// `OrderListViewController`
/// This view controller is responsible for displaying the list of orders placed
/// by the currently logged-in user.
/// - Uses **Core Data** to fetch orders filtered by `loggedInUserID`.
/// - Shows an empty label if no orders are available.
/// - Displays order data inside a table view when available.
class OrderListViewController: UIViewController {

    // MARK: - Outlets

    /// Table view used to display the list of orders.
    @IBOutlet weak var tblView: UITableView!

    // MARK: - Properties

    /// Stores the list of fetched orders for the logged-in user.
    var arrOrders: [Order] = []

    ///For Animation
    private var emptyOrdersAnimationView: LottieAnimationView?
    private var emptyOrdersLabel: UILabel?

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        /// Set navigation title with a back button.
        setLeftAlignedTitleWithBack(
            LocalizationManager.shared.localizedString(
                forKey: Main.OrderList.navtitle
            ),
            target: self,
            action: #selector(backButtonTapped)
        )

        /// Register custom table view cell.
        tblView.register(
            UINib(
                nibName: Main.CellIdentifier.OrderListTableViewCell,
                bundle: nil
            ),
            forCellReuseIdentifier: Main.CellIdentifier.OrderListTableViewCell
        )

        /// Hide vertical scroll indicator for cleaner UI.
        tblView.showsVerticalScrollIndicator = false
        tblView.delegate = self
        tblView.dataSource = self

        /// Fetch orders from Core Data when view loads.
        fetchOrdersFromCoreData()

        setupAni()
    }

    func setupAni() {
        emptyOrdersAnimationView = LottieAnimationView(name: "Delivery Riding")
        if let emptyOrdersAnimationView = emptyOrdersAnimationView {
            emptyOrdersAnimationView.contentMode = .scaleAspectFit
            emptyOrdersAnimationView.loopMode = .loop
            emptyOrdersAnimationView.isHidden = true
            emptyOrdersAnimationView.translatesAutoresizingMaskIntoConstraints =
                false
            view.addSubview(emptyOrdersAnimationView)

            NSLayoutConstraint.activate([
                emptyOrdersAnimationView.centerXAnchor.constraint(
                    equalTo: view.centerXAnchor
                ),
                emptyOrdersAnimationView.centerYAnchor.constraint(
                    equalTo: view.centerYAnchor,
                    constant: -50
                ),
                emptyOrdersAnimationView.widthAnchor.constraint(
                    equalTo: view.widthAnchor,
                    multiplier: 0.7
                ),
                emptyOrdersAnimationView.heightAnchor.constraint(
                    equalToConstant: 250
                ),
            ])

            //  Add label below animation
            let label = UILabel()
            label.text = "You haven’t placed any orders yet"
            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            label.textColor = .darkGray
            label.textAlignment = .center
            label.isHidden = true
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)

            NSLayoutConstraint.activate([
                label.topAnchor.constraint(
                    equalTo: emptyOrdersAnimationView.bottomAnchor,
                    constant: 12
                ),
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
            emptyOrdersLabel = label
        }
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
            tblView.isHidden = true
            emptyOrdersAnimationView?.isHidden = false
            emptyOrdersAnimationView?.play()
            emptyOrdersLabel?.isHidden = false
        } else {
            tblView.isHidden = false
            tblView.reloadData()
            emptyOrdersAnimationView?.stop()
            emptyOrdersAnimationView?.isHidden = true
            emptyOrdersLabel?.isHidden = true
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
        guard
            let savedUserIDString = UserDefaults.standard.string(
                forKey: "loggedInUserID"
            ),
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            self.arrOrders = []
            self.updateUI()
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Order>(entityName: "Order")

        guard let savedUserID = UUID(uuidString: savedUserIDString) else {
            self.arrOrders = []
            self.updateUI()
            return
        }

        let predicate = NSPredicate(
            format: "userID == %@",
            savedUserID as CVarArg
        )
        fetchRequest.predicate = predicate

        fetchRequest.relationshipKeyPathsForPrefetching = [
            "orderedItems", "orderedItems.product",
        ]

        let sortDescriptor = NSSortDescriptor(key: "orderDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            self.arrOrders = try managedContext.fetch(fetchRequest)
            self.updateUI()
        } catch {
            print("Failed to fetch orders: \(error.localizedDescription)")
            self.arrOrders = []
            self.updateUI()
        }
    }

}
