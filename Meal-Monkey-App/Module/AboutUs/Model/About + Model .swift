//
//  About + Model .swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import Foundation


class AboutModel {
    var strText: String?
    var strTimezone: String?
    var strRightSideText: String?
    var strText2: String?
  
    init(strText: String? = nil, strTimezone: String? = nil, strRightSideText: String? = nil, strText2: String? = nil) {
        self.strText = strText
        self.strTimezone = strTimezone
        self.strRightSideText = strRightSideText
        self.strText2 = strText2
    }
    
    class func addAboutData() -> [AboutModel] {
        return [
            AboutModel(
                strText:
                    "Our mission is to deliver a seamless and intuitive shopping experience that prioritizes user satisfaction. We aim to create a platform where browsing, purchasing, and managing products feels effortless, thanks to our simple user interface and reliable service."
            ),

            AboutModel(
                strText:
                    "We are dedicated to maintaining high standards of performance, transparency, and trust. Our team continuously works to enhance app functionality, ensure data privacy, and provide responsive customer support, making your shopping journey smooth and secure."
            ),

            AboutModel(
                strText:
                    "Your feedback matters. If you have any questions, suggestions, or encounter any issues, we’re here to help. Reach out through our support page or email us directly. Together, we strive to build a better and more inclusive experience for everyone."
            ),
            AboutModel(
                strText:
                    "We believe that technology should serve people. That’s why we constantly refine our platform based on real user behavior and needs, aiming to make every interaction faster, simpler, and more enjoyable."
            ),

            AboutModel(
                strText:
                    "Security is our priority. We use industry-standard protocols to safeguard your personal information and provide a safe and secure shopping environment at all times."
            ),

            AboutModel(
                strText:
                    "We value accessibility and inclusiveness. Our platform is designed to be usable by people of all backgrounds, devices, and technical abilities, ensuring that everyone can benefit from our services."
            ),

            AboutModel(
                strText:
                    "Sustainability matters to us. We support eco-friendly business practices and work with partners who share our values to reduce our environmental impact."
            ),

        ]
    }
    
    class func addNotificationData()-> [AboutModel] {
        return [
                AboutModel(strText: "Order placed successfully",
                           strTimezone: "Just now"),
                AboutModel(strText: "Your payment has been confirmed",
                           strTimezone: "5m ago"),
                AboutModel(strText: "Your food is being prepared",
                           strTimezone: "10m ago"),
                AboutModel(strText: "Delivery agent assigned",
                           strTimezone: "30m ago"),
                AboutModel(strText: "Your order is on the way",
                           strTimezone: "1h ago"),
                AboutModel(strText: "Special discount available!",
                           strTimezone: "2h ago"),
                AboutModel(strText: "Download our new app update",
                           strTimezone: "3h ago"),
                AboutModel(strText: "Refer a friend and earn",
                           strTimezone: "5h ago"),
                AboutModel(strText: "Limited-time deal ending soon",
                           strTimezone: "12h ago"),
                AboutModel(strText: "Delivery completed",
                           strTimezone: "1d ago"),
                AboutModel(strText: "Rate your last meal",
                           strTimezone: "2d ago"),
                AboutModel(strText: "Weekend offer just for you",
                           strTimezone: "3d ago"),
                AboutModel(strText: "Free delivery on orders above ₹299",
                           strTimezone: "5d ago"),
                AboutModel(strText: "Thanks for being with us!",
                           strTimezone: "6d ago"),
                AboutModel(strText: "New restaurants added near you",
                           strTimezone: "1w ago")
            ]
    }
    
    class func addInboxData() -> [AboutModel] {
        return [
            AboutModel(strText: "MealMonkey Promotions",
                       strRightSideText: "6th July",
                       strText2: "Get 20% off on your next meal!"),
            AboutModel(strText: "Order Update",
                       strRightSideText: "6th July",
                       strText2: "Your order is being prepared by the restaurant."),
            AboutModel(strText: "Delivery Reminder",
                       strRightSideText: "6th July",
                       strText2: "Your delivery agent is on the way."),
            AboutModel(strText: "Welcome to MealMonkey",
                       strRightSideText: "6th July",
                       strText2: "Thanks for joining us! Start exploring meals."),
            AboutModel(strText: "Rate Your Experience",
                       strRightSideText: "6th July",
                       strText2: "How was your recent meal order?"),
            AboutModel(strText: "Flash Sale",
                       strRightSideText: "6th July",
                       strText2: "Enjoy 30% off on all pasta orders today only."),
            AboutModel(strText: "New Restaurants",
                       strRightSideText: "6th July",
                       strText2: "Discover trending restaurants in your area."),
            AboutModel(strText: "Refer & Earn",
                       strRightSideText: "6th July",
                       strText2: "Invite friends and earn ₹100 credits!"),
            AboutModel(strText: "Weekend Special",
                       strRightSideText: "6th July",
                       strText2: "Free dessert on orders above ₹499."),
            AboutModel(strText: "MealMonkey Tips", strRightSideText: "6th July",
                       strText2: "Customize your orders with special instructions."),
            AboutModel(strText: "Order Cancelled",
                       strRightSideText: "6th July",
                       strText2: "Your order has been cancelled as requested."),
            AboutModel(strText: "Loyalty Program",
                       strRightSideText: "6th July",
                       strText2: "Collect Monkey Points with every purchase."),
            AboutModel(strText: "Security Update",
                       strRightSideText: "6th July",
                       strText2: "Your password was recently changed."),
            AboutModel(strText: "Account Verified",
                       strRightSideText: "6th July",
                       strText2: "Your account has been successfully verified."),
            AboutModel(strText: "Limited Time Deal",
                       strRightSideText: "6th July",
                       strText2: "Flat ₹50 off on biryani orders today.")
        ]
    }
}
