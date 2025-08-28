//
//  Cart Manager.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 20/08/25.
//

import Foundation
import CoreData
import UIKit

/// Manages cart-related operations including fetching total quantity and sending update notifications.
class CartManager {
    
    // MARK: - Singleton Instance
    
    /// Shared singleton instance of `CartManager`.
    static let shared = CartManager()
    
    /// Private initializer to enforce singleton usage.
    private init() {}
    
    // MARK: - Cart Quantity
    /// Fetches the total cart quantity for the logged-in user from Core Data.
    /// - Returns: The total quantity of items in the cart.
    func getCartQuantity() -> Int {
        guard let savedUserIDString = UserDefaults.standard.string(forKey: "loggedInUserID"),
              let savedUserID = UUID(uuidString: savedUserIDString),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return 0
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cart")
        fetchRequest.predicate = NSPredicate(format: "userID == %@", savedUserID as CVarArg)
        
        do {
            let cartItems = try managedContext.fetch(fetchRequest)
            return cartItems.reduce(0) { $0 + ( $1.value(forKey: "quantity") as? Int ?? 0 ) }
        } catch {
            print("Failed to fetch cart quantity: \(error.localizedDescription)")
            return 0
        }
    }
    
    // MARK: - Notifications
    /// Posts a notification to notify observers that the cart has been updated.
    func notifyCartUpdated() {
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }
}

// MARK: - Notification Extension
extension Notification.Name {
    /// Notification fired when the cart is updated.
    static let cartUpdated = Notification.Name("CartUpdatedNotification")
}
