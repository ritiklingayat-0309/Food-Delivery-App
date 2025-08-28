//
//  Menu Model.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import Foundation

/// Model class representing a menu category in the Meal-Monkey app.
class Menu {
    
    // MARK: - Properties
    
    /// The name of the food category.
    var foodName: String
    
    /// The total quantity of items available in this category.
    var quantity: Int
    
    /// Optional image name representing the category.
    var img: String?
    
    /// Tag used to identify the menu item (used for navigation logic).
    let intsTag: Int
    
    // MARK: - Initializer
    
    /// Initializes a new `Menu` instance.
    /// - Parameters:
    ///   - foodName: The name of the food category.
    ///   - quantity: The number of items available in this category.
    ///   - img: The optional image name for the category.
    ///   - intsTag: The tag identifier for the category.
    init(foodName: String, quantity: Int, img: String? = nil, intsTag: Int) {
        self.foodName = foodName
        self.quantity = quantity
        self.img = img
        self.intsTag = intsTag
    }
    
    // MARK: - Static Methods
    
    /// Provides a default list of menu categories for the app.
    /// - Returns: An array of `Menu` objects with sample data.
    class func addMenuList() -> [Menu] {
        return [
            Menu(foodName: "Food",
                 quantity: 25,
                 img: "ic_Food",
                 intsTag: 0),
            
            Menu(foodName: "Beverages",
                 quantity: 25,
                 img: "ic_Beverages",
                 intsTag: 1),
            
            Menu(foodName: "Desserts",
                 quantity: 20,
                 img: "ic_Desert",
                 intsTag: 2),
        ]
    }
}
