//
//  ModelClass + Features.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import Foundation
import UIKit

/// `Features` represents a single feature item displayed in the app, including
/// an image, title, and subtitle description.
class Features {
    
    // MARK: - Properties
    /// Image representing the feature
    let image: UIImage
    
    /// Title of the feature
    let title: String
    
    /// Subtitle or description of the feature
    let subtitle: String
    
    // MARK: - Initializer
    
    /// Initializes a new `Features` object
    /// - Parameters:
    ///   - image: UIImage representing the feature
    ///   - title: Title string for the feature
    ///   - subtitle: Subtitle string describing the feature
    init(image: UIImage, title: String, subtitle: String) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
    
    // MARK: - Data
    
    /// Provides an array of sample features to display in the app
    /// - Returns: Array of `Features` objects
    class func addData() -> [Features] {
        return [
            Features(
                image: UIImage(named: "ic_Find_Food") ?? UIImage(),
                title: "Find Food You Love",
                subtitle: "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"
            ),
            Features(
                image: UIImage(named: "ic_Fast_Delvery") ?? UIImage(),
                title: "Fast Delivery",
                subtitle: "Fast food delivery to your home, office wherever you are"
            ),
            Features(
                image: UIImage(named: "ic_Live_Tracking") ?? UIImage(),
                title: "Live Tracking",
                subtitle: "Real time tracking of your food on the app once you placed the order"
            )
        ]
    }
}
