//
//  Main Struct .swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 29/08/25.
//

import Foundation

struct Main {
    struct CellIdentifier{
        static let AboutUsTableViewCell = "AboutUsTableViewCell"
        static let CartTableViewCell = "CartTableViewCell"
        static let CashOnDeliveryTableViewCell = "CashOnDeliveryTableViewCell"
        static let GmailTableViewCell = "GmailTableViewCell"
        static let VisaTableViewCell = "VisaTableViewCell"
        static let FeaturesCollectionViewCell = "FeaturesCollectionViewCell"
        static let HomeCategoryCollectionViewCell = "HomeCategoryCollectionViewCell"
        static let PopularCollectionViewCell = "PopularCollectionViewCell"
        static let MostPopularCollectionViewCell = "MostPopularCollectionViewCell"
        static let RecentItemsCollectionViewCell = "RecentItemsCollectionViewCell"
        static let HomeTableViewCell = "HomeTableViewCell"
        static let MenuTableViewCell = "MenuTableViewCell"
        static let DessertsTableViewCell = "DessertsTableViewCell"
        static let MoreTableViewCell = "MoreTableViewCell"
        static let MyOrderTableViewCell = "MyOrderTableViewCell"
        static let OffersTableViewCell = "OffersTableViewCell"
        static let PaymentDetailsTableViewCell = "PaymentDetailsTableViewCell"
    }
    
    struct StoryboardIdentifier{
        static let FeaturesStoryboard = "FeaturesStoryboard"
        static let HomeStoryboard = "HomeStoryboard"
        static let LoginStoryboard = "LoginStoryboard"
        static let Main = "Main"
        static let MenuListStoryboard = "MenuListStoryboard"
        static let MoreStoryboard = "MoreStoryboard"
    }
    
    struct ViewControllerIdentifier{
        static let AboutUsViewController = "AboutUsViewController"
        static let CartViewController = "CartViewController"
        static let CheckOutViewController = "CheckOutViewController"
        static let FeaturesViewController = "FeaturesViewController"
        static let ItemDetailsViewController = "ItemDetailsViewController"
        static let LoginViewController = "LoginViewController"
        static let HomeViewController = "HomeViewController"
        static let MapViewController = "MapViewController"
        static let MenuViewController = "MenuViewController"
        static let DessertsViewController = "DessertsViewController"
        static let MoreViewController = "MoreViewController"
        static let MyOrderViewController = "MyOrderViewController"
        static let NewPasswordViewController = "NewPasswordViewController"
        static let OffersViewController = "OffersViewController"
        static let OrderListViewController = "OrderListViewController"
        static let PaymentDetailsViewController = "PaymentDetailsViewController"
        static let ProfileViewController = "ProfileViewController"
        static let ResetPasswordViewController = "ResetPasswordViewController"
        static let SendOTPViewController = "SendOTPViewController"
        static let SignUpViewController = "SignUpViewController"
        static let SplashScreenViewController = "SplashScreenViewController"
    }
    struct ImageName{
        
        static let circle = "circle"
        static let circlefill = "circle.fill"
        static let heartfill = "heart.fill"
    }
    
    struct AlertString {
        static let invalidInput = "Invalid Input"
        static let enterCardNo = "Please enter a card number."
        static let invalidCardNO = "Invalid Card Number"
        static let cardNoContainDigit = "The card number must contain only digits."
        static let cardNO16Digit = "The card number must be exactly 16 digits long."
        static let error = "Error"
        static let ExpiryMonth = "Please enter the expiry month."
        static let ExpiryYear = "Please enter the expiry year."
        static let enterSecurityCode = "Please enter the security code."
        static let invalidSecurityCode = "Invalid security code"
    
    }
    
}
