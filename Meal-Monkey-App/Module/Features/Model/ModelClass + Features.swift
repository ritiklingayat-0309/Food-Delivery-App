//
//  ModelClass + Features.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import Foundation
import UIKit

class Features {
    let image: UIImage
    let title: String
    let subtitle: String

    init(image: UIImage, title: String, subtitle: String) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }

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
