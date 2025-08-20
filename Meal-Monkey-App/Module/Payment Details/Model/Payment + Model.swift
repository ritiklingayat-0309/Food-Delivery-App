//
//  Payment + Model.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import Foundation

/// Model representing a payment card.
class PaymentModel: NSObject {
    
    // MARK: - Properties
    
    /// Card number (stored as `Int64` for 16-digit support).
    var intCardNumber: Int64?
    
    /// Expiry month of the card (e.g., `"01"` for January).
    var strMonth: String?
    
    /// Expiry year of the card (e.g., `"2026"`).
    var strYear: String?
    
    /// Security code (CVV).
    var intSecurityCode: Int?
    
    /// First name of the cardholder.
    var strFirstName: String?
    
    /// Last name of the cardholder.
    var strLastName: String?
    
    // MARK: - Initializer
    
    /// Initializes a new payment model instance.
    /// - Parameters:
    ///   - intCardNumber: The full card number.
    ///   - strMonth: The expiry month.
    ///   - strYear: The expiry year.
    ///   - intSecurityCode: The card's CVV.
    ///   - strFirstName: The first name of the cardholder.
    ///   - strLastName: The last name of the cardholder.
    init(intCardNumber: Int64? = nil,
         strMonth: String? = nil,
         strYear: String? = nil,
         intSecurityCode: Int? = nil,
         strFirstName: String? = nil,
         strLastName: String? = nil) {
        
        self.intCardNumber = intCardNumber
        self.strMonth = strMonth
        self.strYear = strYear
        self.intSecurityCode = intSecurityCode
        self.strFirstName = strFirstName
        self.strLastName = strLastName
    }
    
    // MARK: - Static Data (Mock Cards)
    /// Returns a sample list of predefined payment cards.
    /// - Note: This is mock/demo data for testing.
    class func addcardDetails() -> [PaymentModel] {
        return [
            PaymentModel(intCardNumber: 4111111111111111,
                         strMonth: "01",
                         strYear: "2026",
                         intSecurityCode: 123,
                         strFirstName: "Akshay",
                         strLastName: "Nena"),
            
            PaymentModel(intCardNumber: 4222222222222222,
                         strMonth: "02",
                         strYear: "2027",
                         intSecurityCode: 456,
                         strFirstName: "John",
                         strLastName: "Doe"),
            
            PaymentModel(intCardNumber: 4333333333333333,
                         strMonth: "03",
                         strYear: "2028",
                         intSecurityCode: 789,
                         strFirstName: "Jane",
                         strLastName: "Smith"),
            
            PaymentModel(intCardNumber: 4444444444444444,
                         strMonth: "04",
                         strYear: "2029",
                         intSecurityCode: 321,
                         strFirstName: "Mark",
                         strLastName: "Taylor"),
            
            PaymentModel(intCardNumber: 4555555555555555,
                         strMonth: "05",
                         strYear: "2030",
                         intSecurityCode: 654,
                         strFirstName: "Emily",
                         strLastName: "Clark")
        ]
    }
}
