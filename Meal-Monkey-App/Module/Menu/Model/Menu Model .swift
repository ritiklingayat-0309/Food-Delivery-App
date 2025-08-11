//
//  Menu Model .swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//


import Foundation
import Foundation

class Menu {
    var foodName: String
    var quantity: Int
    var img: String?   // Image name (from asset catalog)
    
    init(foodName: String, quantity: Int, img: String? = nil) {
        self.foodName = foodName
        self.quantity = quantity
        self.img = img
    }
    
    // Class method to return an array of Menu items
    class func addMenuList() -> [Menu] {
        return [
            Menu(foodName: "Food",
                 quantity: 25,
                 img: "ic_Food"),
            Menu(foodName: "Beverages",
                 quantity: 25,
                 img: "ic_Beverages"),
            Menu(foodName: "Desserts",
                 quantity: 20, img:
                    "ic_Desert"),
        ]
    }
}

