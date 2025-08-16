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
    let intsTag: Int
    
    init(foodName: String, quantity: Int, img: String? = nil, intsTag: Int) {
        self.foodName = foodName
        self.quantity = quantity
        self.img = img
        self.intsTag = intsTag
    }
    
    // Class method to return an array of Menu items
    class func addMenuList() -> [Menu] {
        return [
            Menu(foodName: "Food",
                 quantity: 25,
                 img: "ic_Food", intsTag: 0),
            Menu(foodName: "Beverages",
                 quantity: 25,
                 img: "ic_Beverages", intsTag: 1),
            Menu(foodName: "Desserts",
                 quantity: 20, img:
                    "ic_Desert", intsTag: 2),
        ]
    }
}

