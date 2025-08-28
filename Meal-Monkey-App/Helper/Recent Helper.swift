//
//  Recent Helper.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 11/08/25.
//

import Foundation

/**
 A singleton helper class for managing a list of recently viewed products.
 This class maintains a list of the most recent `ProductModel` objects,
 ensuring that the list does not exceed a maximum item count.
 */
class RecentItemsHelper {
    
    /// The shared singleton instance of `RecentItemsHelper`.
    static let shared = RecentItemsHelper()
    
    /// Private initializer to ensure the class is a true singleton.
    private init() {}
    
    /// An internal array to store the recent products.
    private var recentItems: [ProductModel] = []
    
    /// The maximum number of items allowed in the recent items list.
    private let maxItems = 7
    
    /**
     Adds a new product to the list of recent items.
     If the product already exists in the list, it is moved to the top.
     If the list exceeds the maximum number of items, the oldest item is removed.
     - Parameter product: The `ProductModel` object to be added.
     */
    func addProduct(_ product: ProductModel) {
        if let existingIndex = recentItems.firstIndex(where: { $0.intId == product.intId }) {
            recentItems.remove(at: existingIndex)
        }
        recentItems.insert(product, at: 0)
        if recentItems.count > maxItems {
            recentItems.removeLast()
        }
    }
    
    /**
     Retrieves the current list of recent items.
     - Returns: An array of `ProductModel` objects representing the recent items.
     */
    func getRecentItems() -> [ProductModel] {
        return recentItems
    }
    /**
     Clears all items from the recent items list.
     */
    func clear() {
        recentItems.removeAll()
    }
}
