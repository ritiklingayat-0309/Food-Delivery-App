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

    let imageCafe: String
    let strCafeNameKey: String  // Localization key
    let strRatingKey: String
    let strRestaurantTypeKey: String
    let strFoodTypeKey: String
    let strFourPointNineKey: String

    init(
        imageCafe: String,
        strCafeNameKey: String,
        strRatingKey: String,
        strRestaurantTypeKey: String,
        strFoodTypeKey: String,
        strFourPointNineKey: String
    ) {
        self.imageCafe = imageCafe
        self.strCafeNameKey = strCafeNameKey
        self.strRatingKey = strRatingKey
        self.strRestaurantTypeKey = strRestaurantTypeKey
        self.strFoodTypeKey = strFoodTypeKey
        self.strFourPointNineKey = strFourPointNineKey
    }

    // Computed properties to get localized strings
    var strCafeName: String {
        return LocalizationManager.shared.localizedString(
            forKey: strCafeNameKey
        )
    }

    var strRating: String {
        return LocalizationManager.shared.localizedString(forKey: strRatingKey)
    }

    var strRestaurantType: String {
        return LocalizationManager.shared.localizedString(
            forKey: strRestaurantTypeKey
        )
    }

    var strFoodType: String {
        return LocalizationManager.shared.localizedString(
            forKey: strFoodTypeKey
        )
    }

    var strFourPointNine: String {
        LocalizationManager.shared.localizedString(forKey: strFourPointNineKey)
    }

    // MARK: - Static Data
    class func getAllOffers() -> [offer] {
        return [
            offer(
                imageCafe: Main.ImageName.offer1,
                strCafeNameKey: Main.Offers.cafeName.0,
                strRatingKey: Main.Offers.cafeRating,
                strRestaurantTypeKey: Main.Offers.restroType,
                strFoodTypeKey: Main.Offers.foodType,
                strFourPointNineKey: Main.Offers.fourPoing
            ),
            offer(
                imageCafe: Main.ImageName.offer2,
                strCafeNameKey: Main.Offers.cafeName.1,
                strRatingKey: Main.Offers.cafeRating,
                strRestaurantTypeKey: Main.Offers.restroType,
                strFoodTypeKey: Main.Offers.foodType,
                strFourPointNineKey: Main.Offers.fourPoing
            ),
            offer(
                imageCafe: Main.ImageName.offer3,
                strCafeNameKey: Main.Offers.cafeName.2,
                strRatingKey: Main.Offers.cafeRating,
                strRestaurantTypeKey: Main.Offers.restroType,
                strFoodTypeKey: Main.Offers.foodType,
                strFourPointNineKey: Main.Offers.fourPoing
            ),
        ]
    }
}
