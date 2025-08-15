//
//  More + Model.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import Foundation
import UIKit

class More {
    let image: UIImage
    let title: String
    let intsTag: Int
    
    init(image: UIImage, title: String, intsTag: Int) {
        self.image = image
        self.title = title
        self.intsTag = intsTag
    }
    
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
            More(image: UIImage(named: "ic_wishList") ?? UIImage(),
                 title: "Wish List",
                 intsTag: 5)
        ]
    }
}

