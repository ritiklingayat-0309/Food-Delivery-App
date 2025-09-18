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
    let image: UIImage
    let title: String
    let subtitle: String

    init(image: UIImage, titleKey: String, subtitleKey: String) {
        self.image = image
        self.title = LocalizationManager.shared.localizedString(
            forKey: titleKey
        )
        self.subtitle = LocalizationManager.shared.localizedString(
            forKey: subtitleKey
        )
    }

    class func addData() -> [Features] {
        return [
            Features(
                image: UIImage(named: Main.ImageName.Features_img1)
                    ?? UIImage(),
                titleKey: Main.Features.titile.0,
                subtitleKey: Main.Features.subtitile.0
            ),
            Features(
                image: UIImage(named: Main.ImageName.Features_img2)
                    ?? UIImage(),
                titleKey: Main.Features.titile.1,
                subtitleKey: Main.Features.subtitile.1
            ),
            Features(
                image: UIImage(named: Main.ImageName.Features_img3)
                    ?? UIImage(),
                titleKey: Main.Features.titile.2,
                subtitleKey: Main.Features.subtitile.2
            ),
        ]
    }
}
