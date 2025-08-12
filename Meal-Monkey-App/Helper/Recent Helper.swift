//
//  Recent Helper.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 11/08/25.
//


import Foundation

class RecentItemsHelper {
    static let shared = RecentItemsHelper()
    private init() {}
    private var recentItems: [ProductModel] = []
    private let maxItems = 7
    
    func addProduct(_ product: ProductModel) {
        if let existingIndex = recentItems.firstIndex(where: { $0.intId == product.intId }) {
            recentItems.remove(at: existingIndex)
        }
        recentItems.insert(product, at: 0)
        if recentItems.count > maxItems {
            recentItems.removeLast()
        }
    }
    
    func getRecentItems() -> [ProductModel] {
        return recentItems
    }
    
    func clear() {
        recentItems.removeAll()
    }
}

