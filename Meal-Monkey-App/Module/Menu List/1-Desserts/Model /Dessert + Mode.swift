//
//  Dessert + Model.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//
import Foundation

class Desserts {
    var topImageName: String
    var bottomImageName: String
    var dessertName: String
    var rating: Double
    var restaurantName: String
    var category: String
    
    init(topImageName: String, bottomImageName: String, dessertName: String, rating: Double, restaurantName: String, category: String) {
        self.topImageName = topImageName
        self.bottomImageName = bottomImageName
        self.dessertName = dessertName
        self.rating = rating
        self.restaurantName = restaurantName
        self.category = category
    }
    
    class func getDessertList() -> [Desserts] {
        return [
            Desserts(topImageName: "ic_French_Apple_Pie",
                     bottomImageName: "ic_common",
                     dessertName: "French Apple Pie",
                     rating: 4.9,
                     restaurantName: "Minute by tuk tuk",
                     category: "Desserts"),
            Desserts(topImageName: "ic_Dark_chocolate_Cake",
                     bottomImageName: "ic_common",
                     dessertName: "Dark Chocolate Cake",
                     rating: 4.9,
                     restaurantName: "Minute by tuk tuk",
                     category: "Desserts"),
            Desserts(topImageName: "ic_Street_Shake",
                     bottomImageName: "ic_common",
                     dessertName: "Street Shake",
                     rating: 4.9,
                     restaurantName: "Minute by tuk tuk",
                     category: "Desserts"),
            Desserts(topImageName: "ic_Fudgy_Chewy_Brownies",
                     bottomImageName: "ic_common",
                     dessertName: "Fudgy Chewy Brownies",
                     rating: 4.9,
                     restaurantName: "Minute by tuk tuk",
                     category: "Desserts")
        ]
    }
}
