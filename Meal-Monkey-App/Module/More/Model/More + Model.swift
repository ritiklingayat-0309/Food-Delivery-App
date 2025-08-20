//
//  More + Model.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import Foundation
import UIKit

/// Model representing an option in the "More" section of the app.
/// Each option includes an image, title, and an identifier tag.
class More {
    
    // MARK: - Properties
    
    /// Icon for the menu item (from assets or SF Symbols).
    let image: UIImage
    
    /// Title text displayed for the menu item.
    let title: String
    
    /// Unique tag used to identify which menu item was selected.
    /// Matches with cases inside the `didSelectRowAt` switch.
    let intsTag: Int
    
    // MARK: - Initializer
    
    /// Creates a new `More` object.
    /// - Parameters:
    ///   - image: Image to display.
    ///   - title: Title of the option.
    ///   - intsTag: Unique identifier tag for selection handling.
    init(image: UIImage, title: String, intsTag: Int) {
        self.image = image
        self.title = title
        self.intsTag = intsTag
    }
    
    // MARK: - Static Data
    
    /// Provides the default list of menu options for the "More" screen.
    /// - Returns: An array of `More` objects.
    class func addData() -> [More] {
        return [
            More(image: UIImage(named: "ic_payment") ?? UIImage(),
                 title: "Payment Details",
                 intsTag: 0),
            
            More(image: UIImage(named: "ic_order") ?? UIImage(),
                 title: "My Orders",
                 intsTag: 1),
            
            More(image: UIImage(named: "ic_notification") ?? UIImage(),
                 title: "Notifications",
                 intsTag: 2),
            
            More(image: UIImage(named: "ic_inbox2") ?? UIImage(),
                 title: "Inbox",
                 intsTag: 3),
            
            More(image: UIImage(named: "ic_about") ?? UIImage(),
                 title: "About Us",
                 intsTag: 4),
            
            More(image: UIImage(systemName: "heart.fill")?.withTintColor(
                UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1),
                renderingMode: .alwaysOriginal
            ) ?? UIImage(),
                 title: "Wish List",
                 intsTag: 5
            )
        ]
    }
}
