//
//  Offer + Model.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import Foundation
import UIKit

/// Model class representing an offer in the app.
///
/// Each offer contains information such as:
/// - Café image
/// - Café name
/// - Number of ratings
/// - Restaurant type
/// - Food type
///
/// Example usage:
/// ```swift
/// let allOffers = offer.getAllOffers()
/// print(allOffers.first?.strCafeName ?? "No Offers")
/// ```
class offer: NSObject {
    
    // MARK: - Properties
    
    /// Image name of the café (used to load from assets).
    let imageCafe: String
    
    /// Name of the café.
    let strCafeName: String
    
    /// Number of ratings in string format (e.g., "(124 ratings)").
    let strNoOfRatings: String
    
    /// Type of restaurant (e.g., "Café").
    let strRestaurantType: String
    
    /// Type of food served (e.g., "Western Food").
    let strFoodType: String
    
    // MARK: - Initializer
    
    /// Initializes a new `offer` object with given details.
    /// - Parameters:
    ///   - imageCafe: Café image name from assets.
    ///   - strCafeName: Name of the café.
    ///   - strNoOfRatings: Ratings count.
    ///   - strRestaurantType: Type of restaurant.
    ///   - strFoodType: Type of food offered.
    init(
        imageCafe: String,
        strCafeName: String,
        strNoOfRatings: String,
        strRestaurantType: String,
        strFoodType: String
    ) {
        self.imageCafe = imageCafe
        self.strCafeName = strCafeName
        self.strNoOfRatings = strNoOfRatings
        self.strRestaurantType = strRestaurantType
        self.strFoodType = strFoodType
    }
    
    // MARK: - Static Data
    /// Returns a list of pre-defined offers.
    /// Used for demo or testing purposes, representing available café offers.
    /// - Returns: Array of `offer` objects.
    class func getAllOffers() -> [offer] {
        return [
            offer(
                imageCafe: "ic_offer_cafede",
                strCafeName: "Café de Noires",
                strNoOfRatings: "(124 ratings)",
                strRestaurantType: "Café",
                strFoodType: "Western Food"
            ),
            offer(
                imageCafe: "ic_offer_Isso",
                strCafeName: "Isso",
                strNoOfRatings: "(124 ratings)",
                strRestaurantType: "Café",
                strFoodType: "Western Food"
            ),
            offer(
                imageCafe: "ic_offer_cafeBean",
                strCafeName: "Cafe Beans",
                strNoOfRatings: "(124 ratings)",
                strRestaurantType: "Café",
                strFoodType: "Western Food"
            )
        ]
    }
}
