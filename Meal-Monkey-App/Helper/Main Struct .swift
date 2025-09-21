//
//  Main Struct .swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 29/08/25.
//

import Foundation

struct Main {

    struct CellIdentifier {
        static let AboutUsTableViewCell = "AboutUsTableViewCell"
        static let CartTableViewCell = "CartTableViewCell"
        static let CashOnDeliveryTableViewCell = "CashOnDeliveryTableViewCell"
        static let GmailTableViewCell = "GmailTableViewCell"
        static let VisaTableViewCell = "VisaTableViewCell"
        static let FeaturesCollectionViewCell = "FeaturesCollectionViewCell"
        static let HomeCategoryCollectionViewCell =
            "HomeCategoryCollectionViewCell"
        static let PopularCollectionViewCell = "PopularCollectionViewCell"
        static let MostPopularCollectionViewCell =
            "MostPopularCollectionViewCell"
        static let RecentItemsCollectionViewCell =
            "RecentItemsCollectionViewCell"
        static let HomeTableViewCell = "HomeTableViewCell"
        static let MenuTableViewCell = "MenuTableViewCell"
        static let DessertsTableViewCell = "DessertsTableViewCell"
        static let MoreTableViewCell = "MoreTableViewCell"
        static let MyOrderTableViewCell = "MyOrderTableViewCell"
        static let OffersTableViewCell = "OffersTableViewCell"
        static let PaymentDetailsTableViewCell = "PaymentDetailsTableViewCell"
        static let OrderListTableViewCell = "OrderListTableViewCell"
        static let LanguageTableViewCell = "LanguageTableViewCell"
    }

    struct StoryboardIdentifier {
        static let FeaturesStoryboard = "FeaturesStoryboard"
        static let HomeStoryboard = "HomeStoryboard"
        static let LoginStoryboard = "LoginStoryboard"
        static let Main = "Main"
        static let MenuListStoryboard = "MenuListStoryboard"
        static let MoreStoryboard = "MoreStoryboard"
    }

    struct ViewControllerIdentifier {
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
        static let LanguageViewController = "LanguageViewController"
    }

    struct Colors {
        static let transparent = "Transparentcolor"  // Transparent color reference
        static let navigationcolor = "NavigationColor"  // Navigation bar color
        static let navigationBackBtnColor = "chevron.backward"  // Back button color/icon
        static let fontTextfield = "HelveticaNeue-Bold"  // Font used in textfields
    }

    struct ImageName {
        //checkout Cell
        static let circle = "circle"
        static let circlefill = "circle.fill"
        static let heartfill = "heart.fill"

        //details page
        static let heart = "heart"
        static let heartFill = "heart.fill"

        //EyeButton
        static let eye = "eye"
        static let eyeSlash = "eye.slash"

        // Home page Category Imges
        static let all = "ic_butternaan"
        static let paneertikka = "ic_paneertikka"
        static let hakkanoodles = "ic_hakkanoodles"
        static let khamanDhokla = "Ic_Khaman_Dhokla"
        static let masalaDosa = "ic_masaladosa"
        static let margheritaPizza = "ic_margherita_pizza"

        //menu page
        static let food = "ic_Food"
        static let beverages = "ic_Beverages"
        static let desserts = "ic_Desert"

        //more page
        static let paymentDetails = "ic_payment"
        static let myOrders = "ic_order"
        static let notification = "ic_notification"
        static let inbox = "ic_inbox2"
        static let aboutUs = "ic_about"
        static let wishlist = "heart.fill"
        static let language = "globe"
        static let theam = "moon.fill"

        //features Page
        static let Features_img1 = "ic_Find_Food"
        static let Features_img2 = "ic_Fast_Delvery"
        static let Features_img3 = "ic_Live_Tracking"

        //offer page
        static let offer1 = "ic_offer_cafede"
        static let offer2 = "ic_offer_Isso"
        static let offer3 = "ic_offer_cafeBean"

        //Map page
        static let addressCustomPin = "Ic_Location_Pin"

    }

    struct aboutUsModel {
        static let strText1 = "about_us_text1_03"
        static let strText2 = "about_us_text2_03"
        static let strText3 = "about_us_text3_03"
        static let strText4 = "about_us_text4_03"
        static let strText5 = "about_us_text5_03"
        static let strText6 = "about_us_text6_03"
        static let strText7 = "about_us_text7_03"
        static let navNotification = "title_notification_03"
        static let navInbox = "title_inbox_03"
        static let navAbout = "title_about_us_03"
    }

    struct inboxModel {
        static let promotions = (
            "inbox_promotions_title_03", "inbox_promotions_date_03",
            "inbox_promotions_desc_03"
        )

        static let orderUpdate = (
            "inbox_order_update_title_03", "inbox_promotions_date_03",
            "inbox_order_update_desc_03"
        )

        static let deliveryReminders = (
            "inbox_delivery_reminder_title_03", "inbox_promotions_date_03",
            "inbox_delivery_reminder_desc_03"
        )

        static let welcome = (
            "inbox_welcome_title_03", "inbox_promotions_date_03",
            "inbox_welcome_desc_03"
        )

        static let experience = (
            "inbox_experience_title_03", "inbox_promotions_date_03",
            "inbox_experience_desc_03"
        )

        static let flashSale = (
            "inbox_flash_sale_title_03", "inbox_promotions_date_03",
            "inbox_flash_sale_desc_03"
        )

        static let newRestaurants = (
            "inbox_new_restaurants_title_03", "inbox_promotions_date_03",
            "inbox_new_restaurants_desc_03"
        )

        static let referEarn = (
            "inbox_refer_earn_title_03", "inbox_promotions_date_03",
            "inbox_refer_earn_desc_03"
        )

        static let weekendSpecial = (
            "inbox_weekend_special_title_03", "inbox_promotions_date_03",
            "inbox_weekend_special_desc_03"
        )

        static let tips = (
            "inbox_tips_title_03", "inbox_promotions_date_03",
            "inbox_tips_desc_03"
        )

        static let orderCancel = (
            "inbox_order_cancel_title_03", "inbox_promotions_date_03",
            "inbox_order_cancel_desc_03"
        )

        static let loyaltyProgram = (
            "inbox_loyalty_program_title_03", "inbox_promotions_date_03",
            "inbox_loyalty_program_desc_03"
        )

        static let securityUpdate = (
            "inbox_security_update_title_03", "inbox_promotions_date_03",
            "inbox_security_update_desc_03"
        )

        static let accountVerified = (
            "inbox_account_verified_title_03", "inbox_promotions_date_03",
            "inbox_account_verified_desc_03"
        )

        static let limitedDeal = (
            "inbox_limited_deal_title_03", "inbox_promotions_date_03",
            "inbox_limited_deal_desc_03"
        )
    }

    struct notificationModel {
        static let orderPlaced = (
            "notification_order_placed_03", "notification_order_placed_time_03"
        )

        static let paymentConfirmed = (
            "notification_payment_confirmed_03",
            "notification_payment_confirmed_time_03"
        )

        static let foodPrepared = (
            "notification_food_prepared_03",
            "notification_food_prepared_time_03"
        )

        static let agentAssigned = (
            "notification_agent_assigned_03",
            "notification_agent_assigned_time_03"
        )

        static let orderOnWay = (
            "notification_order_on_way_03", "notification_order_on_way_time_03"
        )

        static let discount = (
            "notification_discount_03", "notification_discount_time_03"
        )

        static let appUpdate = (
            "notification_app_update_03", "notification_app_update_time_03"
        )

        static let referFriend = (
            "notification_refer_friend_03", "notification_refer_friend_time_03"
        )

        static let limitedDeal = (
            "notification_limited_deal_03", "notification_limited_deal_time_03"
        )

        static let deliveryDone = (
            "notification_delivery_done_03",
            "notification_delivery_done_time_03"
        )

        static let rateMeal = (
            "notification_rate_meal_03", "notification_rate_meal_time_03"
        )

        static let weekendOffer = (
            "notification_weekend_offer_03",
            "notification_weekend_offer_time_03"
        )

        static let freeDelivery = (
            "notification_free_delivery_03",
            "notification_free_delivery_time_03"
        )

        static let thanks = (
            "notification_thanks_03", "notification_thanks_time_03"
        )

        static let newRestaurants = (
            "notification_new_restaurants_03",
            "notification_new_restaurants_time_03"
        )
    }

    struct Features {
        static let titile = (
            "features_title_1_03", "features_title_2_03", "features_title_3_03"
        )
        static let subtitile = (
            "features_subtitle_1_03", "features_subtitle_2_03",
            "features_subtitle_3_03"
        )
        static let btnDone = "features_done_button_03"
        static let btnNext = "features_next_button_03"

    }

    struct EmptyLabel {
        static let emptyWishlist = "empty_wishlist_message_03"
        static let emptyCart = "empty_cart_message_03"
    }

    struct Offers {
        static let offernav = "offers_nav_title_03"
        static let latestOffer = "offers_lbl_latest_03"
        static let btnCheckOffer = "offers_btn_check_03"
        static let cafeName = (
            "offers_cafe_03_0", "offers_cafe_03_1", "offers_cafe_03_2"
        )
        static let cafeRating = "offers_rating_03"
        static let restroType = "offers_restrotype_03"
        static let foodType = "offers_foodtype_03"
        static let fourPoing = "offers_four_point_nine_03"

    }

    struct MyOrder {
        static let myOrdernav = "my_order_title_03"
        static let deliveryinstruction = "delivery_instructions_03"
        static let subtotal = "my_order_title_03"
        static let deliveryCost = "my_order_title_03"
        static let total = "my_order_title_03"
        static let kingBurger = "king_burger_03"
        static let fourPointFive = "offers_four_point_nine_03"
        static let rating = "rating_03"
        static let address = "address_03"
        static let btnAddNote = "add_note_03"
        static let btncheckout = "checkout_03"
    }

    struct NewPassword {
        static let newpass1 = "new_password_title_03"
        static let newpass2 = "enter_email_to_reset_pass_title_03"
        static let txtnewpass = "new_password_placeholder_03"
        static let txtconfirmpass = "confirm_password_placeholder_03"
        static let btnNext = "next_button_03"
    }

    struct menu {
        static let menunav = "menu_nav_title"
        static let searchbar = "search_placeholder"
        static let emptySearch = "no_result_found"
        static let food = "menu_food_03"
        static let beverages = "menu_beverages_03"
        static let desserts = "menu_desserts_03"
        static let foodQ = "menu_quantity_items_03"
        static let rowQ = "25"
    }

    struct Dessert {
        static let navFood = "title_food_03"
        static let navBeverages = "title_beverages_03"
        static let navDessert = "title_desserts_03"
        static let seartchBar = "search_food_03"

    }

    struct Home {
        static let popular = "Popular"
        static let searchResult = "Search Results"
        static let MostPopular = "Most Popular"
        static let recentItems = "Recent Items"
        static let deliveringto = "label_delivering_to_03"
        static let searchFood = "search_food_03"
        static let greeting = "greeting_good_morning"
        static let Notifiation = (
            "📢 Notification 1: Welcome to Meal Monkey!",
            "🔥 Notification 2: Don't miss today’s offers.",
            "⭐️ Notification 3: Try our top-rated dishes!",
            "🚀 Notification 4: Hungry? Order now!",
            "✅ Notification 5: Thank you for using our app!"
        )
        static let Nofititle = "Meal Monkey 🍔"

    }

    struct Login {
        static let loginTitle1 = "login_title"
        static let loginTitle2 = "login_subtitle"
        static let orWith = "login_or_with"
        static let btnlogin = "login_button"
        static let btnForgest = "forgot_password_button"
        static let btnWithface = "login_with_facebook"
        static let btnWithgo = "login_with_google"
        static let btnsignup = "signup_button"
        static let txtemail = "email_placeholder"
        static let txtpass = "password_placeholder"
    }
    
    struct more {
        static let navMore = "more_title_03"
        static let paymentDetails = "more_payment_details_03"
        static let myOrder = "more_my_orders_03"
        static let notification = "more_notification_03"
        static let inbox = "more_inbox_03"
        static let aboutUs = "more_about_us_03"
        static let wishlist = "more_wishlist_03"
        static let Language = "more_language_03"
        static let theme = "more_theme_03"
    }

    struct AlertTitle {
        //all forms
        static let error = "error"
        static let invalidEmail = "invalid_email_title"
        static let invalidPassword = "invalid_password_title"
        static let success = "success"
        static let otptitle = "otp_title"

        //for card
        static let invalidInput = "invalid_input_title"
        static let invalidCardNumber = "Invalid Card Number"
        static let invalidSecurityCode = "invalid_security_code_title"
        static let duplicateCard = "duplicate_card_title"

        //cart Page
        static let orderPlaced = "order_placed_title"
        static let emptyCart = "Empty Cart"

    }

    struct AlertMessage {
        //all forms
        //signup
        static let enterName = "enter_name_msg"
        static let enterEmail = "enter_email_msg"
        static let invalidEmail = "invalid_email_msg"
        static let enterMobile = "enter_mobile_msg"
        static let digitsOnly = "digits_only_msg"
        static let mobileLength = "mobile_length_msg"
        static let enterAddress = "enter_address_msg"
        static let enterPassword = "enter_password_msg"
        static let invalidPassword = "invalid_password_msg"
        static let enterConfirmPassword = "enter_confirm_password_msg"
        static let passwordMismatch = "password_mismatch_msg"
        static let registrationSuccess = "registration_success_msg"
        static let registrationFailed = "registration_failed_msg"

        //otp
        static let otpMessage = "otp_message_msg"

        //profile
        static let profileUpdate = "profile_update_success_msg_03"
        static let profileUpdateError = "profile_update_error_msg_03"
        static let usrNotFound = "user_not_found_msg"
        static let loginFailed = "login_failed_msg"

        // for card
        static let emptyCardNumber = "empty_card_number_msg"
        static let invalidCardDigits = "invalid_card_digits_msg"
        static let invalidCardLength = "invalid_card_length_msg"
        static let emptyExpiryMonth = "empty_expiry_month_msg"
        static let expMonthvalid = "expiry_month_validate_msg"
        static let exYearValid = "invalid_expiry_month_range_msg"
        static let emptyExpiryYear = "empty_expiry_year_msg"
        static let yearRange = "expiry_year_validate_msg"
        static let yearExp2 = "card_expiry_date_msg"
        static let emptySecurityCode = "empty_security_code_msg"
        static let invalidSecurityCodeDigits =
            "invalid_security_code_digits_msg"
        static let invalidSecurityCodeLength =
            "invalid_security_code_length_msg"
        static let emptyFirstName = "empty_first_name_msg"
        static let invalidFirstName = "invalid_first_name_msg"
        static let emptyLastName = "empty_last_name_msg"
        static let invalidLastName = "invalid_last_name_msg"
        static let duplicateCard = "duplicate_card_msg"

        //cart Page
        static let addedIncart = "added_to_cart_03"
        static let orderPlcedSuccess = "order_placed_success_msg"
        static let failedToPlaceOrder =
            "Failed to place order. Please try again."
        static let addItemBeforPlaced =
            "Please add items before placing an order."
    }

    struct Language {
        // language
        static let english = "English"
        static let marathi = "Marathi"
        static let hindi = "Hindi"
        static let gujrati = "Gujrati"
        static let tamil = "tamil"
        static let urdu = "urdu"
        //theme
    }

    struct ItemDetails {
        static let navtitle = "title_food_detail_03"
        static let ingredian = "label_select_ingredients_03"
        static let sizeofPortion = "label_select_portion_size_03"
        static let totalPrize = "label_total_price_03"
        static let numberOfPortion = "label_number_of_portions_03"
        static let customizedYou = "label_customize_order_03"
        static let description = "label_description_03"
        static let btnAddCart = "button_add_to_cart_03"
    }

    struct checkOut {
        static let navTitile = "checkout_title"
        static let deliveryAddress = "checkout_delivery_address"
        static let changeAddress = "checkout_change_address"
        static let btnSendOrder = "checkout_send_order"
        static let paymentMethod = "checkout_delivery_address"
        static let total = "checkout_total"
        static let discount = "checkout_discount"
        static let deliveryCost = "checkout_delivery_cost"
        static let subTotal = "checkout_subtotal"
        static let btnAddCard = "checkout_add_card"
        static let thankyou = "thank_you_03"
        static let forYourOrder = "for_your_order_03"
        static let yourOrder = "your_order_03"
        static let btnTrakMyOrder = "track_my_order_03"
        static let btnBakcToHome = "back_to_home_03"
        static let btnchageAdd = "change_address_03"
    }

    struct Otp {
        //for OTP title
        static let otptitle1 = "verify_otp_title_03"
        static let otptitle2 = "enter_otp_subtitle_03"
        static let btnNext = "next_button_03"
    }

    struct Profile {
        static let navProfile = "profile_nav_title_03"
        static let namePlc = "profile_lbl_name_placeholder_03"
        static let emailPlc = "profile_lbl_email_placeholder_03"
        static let mobilePlc = "profile_lbl_mobile_placeholder_03"
        static let addressPlc = "profile_lbl_address_placeholder_03"
        static let btnEditPro = "profile_btn_edit_03"
        static let btnSave = "profile_btn_save_03"
        static let btnSignOut = "profile_btn_signout_03"
        static let greeting = "profile_lbl_title_user_03"
    }

    struct ResetPass {
        static let restitl1 = "reset_password_title_03"
        static let restitl2 = "enter_your_email_title_03"
        static let resttxt = "email_placeholder_03"
        static let btnsend = "send_button_03"
    }

    struct PaymentDetails {
        static let otherMethod = "other_method_label_03"
        static let cashOnDelivery = "cash_on_delivery_label_03"
        static let btnDelete = "delete_card_button_title_03"
        static let navtitle = "payment_details_title"
        static let customizePay = "customize_payment_method_label"
        static let btnAddcard = "add_card_button_title"
        static let btnAddAnother = "add_another_card_button_title"
        static let txtCardNO = "card_number_placeholder_03"
        static let txtSecurity = "security_code_placeholder_03"
        static let txtfirstname = "first_name_placeholder_03"
        static let txtlastname = "last_name_placeholder_03"
        static let txtexpirymonth = "expiry_month_placeholder_03"
        static let txtexpiryyear = "expiry_year_placeholder_03"
        static let lbladdcredi = "add_credit_label_03"
        static let lblexpiry = "expiry_label_03"
        static let lblyoucanremove = "you_can_remove_label_03"
        static let noCardsave = "no_saved_cards_msg"

    }

    struct OrderList {
        static let navtitle = "order_list_title_03"
    }

    struct Map {
        static let fullAddress = "Unknown Location"
        static let AnnotaionTitle = "Loading address..."
        static let permissiontitle = "Location Permission Needed"
        static let permissionmessage =
            "Please enable location access in Settings to use this feature."
        static let alertCancel = "Cancel"
        static let alertTitleOpenSettings = "Open Settings"

    }

    struct Cart {
        static let navcart = "cart_nav_title_cart_03"
        static let navWish = "cart_nav_title_wishlist_03"
        static let category = "cart_category_label_03"
        static let price = "cart_price_label_03"
        static let type = "cart_type_label_03"
        static let btnPlacedOrder = "place_order_button_title_03"
    }
}
