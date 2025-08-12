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
    
    init(image: UIImage, title: String) {
        self.image = image
        self.title = title
    }
    
    class func addData() -> [More] {
        return [
            More(image: UIImage(named: "ic_payment") ?? UIImage(),
                 title: "Payment Details"),
            More(image: UIImage(named: "ic_order") ?? UIImage(),
                 title: "My Orders"),
            More(image: UIImage(named: "ic_notification") ?? UIImage(),
                 title: "Notifications"),
            More(image: UIImage(named: "ic_inbox2") ?? UIImage(),
                 title: "Inbox"),
            More(image: UIImage(named: "ic_about") ?? UIImage(),
                 title: "About Us")
        ]
    }
}

