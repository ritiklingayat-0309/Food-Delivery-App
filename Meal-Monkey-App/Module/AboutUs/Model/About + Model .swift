//
//  About + Model .swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 05/08/25.
//

import Foundation

/**
 A model class that holds data for the "About," "Notifications," and "Inbox" sections.
 This class provides static methods to generate pre-defined data arrays, which are used
 to populate the user interface for informational and notification-based screens.
 */

class AboutModel {
    
    var strText: String?
    var strTimezone: String?
    var strRightSideText: String?
    var strText2: String?

    init(
        strText: String? = nil,
        strTimezone: String? = nil,
        strRightSideText: String? = nil,
        strText2: String? = nil
    ) {
        self.strText = strText
        self.strTimezone = strTimezone
        self.strRightSideText = strRightSideText
        self.strText2 = strText2
    }

    // MARK: - About Section
    class func addAboutData() -> [AboutModel] {
        return [
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.aboutUsModel.strText1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.aboutUsModel.strText2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.aboutUsModel.strText3
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.aboutUsModel.strText4
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.aboutUsModel.strText5
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.aboutUsModel.strText6
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.aboutUsModel.strText7
                )
            ),
        ]
    }

    // MARK: - Notifications Section
    class func addNotificationData() -> [AboutModel] {
        return [
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.orderPlaced.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.orderPlaced.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.paymentConfirmed.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.paymentConfirmed.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.foodPrepared.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.foodPrepared.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.agentAssigned.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.agentAssigned.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.orderOnWay.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.orderOnWay.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.discount.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.discount.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.appUpdate.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.appUpdate.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.referFriend.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.referFriend.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.limitedDeal.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.limitedDeal.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.deliveryDone.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.deliveryDone.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.rateMeal.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.rateMeal.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.weekendOffer.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.weekendOffer.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.freeDelivery.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.freeDelivery.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.thanks.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.thanks.1
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.newRestaurants.0
                ),
                strTimezone: LocalizationManager.shared.localizedString(
                    forKey: Main.notificationModel.newRestaurants.1
                )
            ),
        ]
    }

    // MARK: - Inbox Section
    class func addInboxData() -> [AboutModel] {
        return [
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.promotions.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.promotions.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.promotions.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.orderUpdate.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.orderUpdate.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.orderUpdate.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.deliveryReminders.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.deliveryReminders.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.deliveryReminders.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.welcome.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.welcome.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.welcome.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.experience.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.experience.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.experience.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.flashSale.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.flashSale.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.flashSale.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.newRestaurants.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.newRestaurants.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.newRestaurants.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.referEarn.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.referEarn.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.referEarn.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.weekendSpecial.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.weekendSpecial.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.weekendSpecial.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.tips.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.tips.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.tips.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.orderCancel.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.orderCancel.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.orderCancel.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.loyaltyProgram.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.loyaltyProgram.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.loyaltyProgram.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.securityUpdate.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.securityUpdate.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.securityUpdate.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.accountVerified.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.accountVerified.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.accountVerified.2
                )
            ),
            AboutModel(
                strText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.limitedDeal.0
                ),
                strRightSideText: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.limitedDeal.1
                ),
                strText2: LocalizationManager.shared.localizedString(
                    forKey: Main.inboxModel.limitedDeal.2
                )
            ),
        ]
    }
}
