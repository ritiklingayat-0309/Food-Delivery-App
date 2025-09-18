//
//  Menu Model.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import Foundation

class Menu {

    // Store keys instead of localized strings
    let foodKey: String
    let quantityKey: String
    var img: String?
    let intsTag: Int

    init(foodKey: String, quantityKey: String, img: String? = nil, intsTag: Int)
    {
        self.foodKey = foodKey
        self.quantityKey = quantityKey
        self.img = img
        self.intsTag = intsTag
    }

    // Computed property: always fetch latest localization
    var foodName: String {
        return LocalizationManager.shared.localizedString(forKey: foodKey)
    }

    var quantityText: String {
        let rawQuantity = LocalizationManager.shared.localizedString(
            forKey: quantityKey
        )
        return String(format: rawQuantity, Main.menu.rowQ)  // or actual quantity
    }

    class func addMenuList() -> [Menu] {
        return [
            Menu(
                foodKey: Main.menu.food,
                quantityKey: Main.menu.foodQ,
                img: Main.ImageName.food,
                intsTag: 0
            ),

            Menu(
                foodKey: Main.menu.beverages,
                quantityKey: Main.menu.foodQ,
                img: Main.ImageName.beverages,
                intsTag: 1
            ),

            Menu(
                foodKey: Main.menu.desserts,
                quantityKey: Main.menu.foodQ,
                img: Main.ImageName.desserts,
                intsTag: 2
            ),
        ]
    }
}
