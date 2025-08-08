//
//  Payment + Model.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import Foundation

class PaymentModel : NSObject{
    var intCardNumber:Int64?
    var strMonth:String?
    var strYear:String?
    var intSecurityCode:Int?
    var strFirstName:String?
    var strLastName:String?
    
    init(intCardNumber: Int64? = nil, strMonth: String? = nil, strYear: String? = nil, intSecurityCode: Int? = nil, strFirstName: String? = nil, strLastName: String? = nil) {
        self.intCardNumber = intCardNumber
        self.strMonth = strMonth
        self.strYear = strYear
        self.intSecurityCode = intSecurityCode
        self.strFirstName = strFirstName
        self.strLastName = strLastName
    }
    
    class func addcardDetails() -> [PaymentModel] {
            return [
                PaymentModel(intCardNumber: 4111111111111111, strMonth: "01", strYear: "2026", intSecurityCode: 123, strFirstName: "Akshay", strLastName: "Nena"),
                PaymentModel(intCardNumber: 4222222222222222, strMonth: "02", strYear: "2027", intSecurityCode: 456, strFirstName: "John", strLastName: "Doe"),
                PaymentModel(intCardNumber: 4333333333333333, strMonth: "03", strYear: "2028", intSecurityCode: 789, strFirstName: "Jane", strLastName: "Smith"),
                PaymentModel(intCardNumber: 4444444444444444, strMonth: "04", strYear: "2029", intSecurityCode: 321, strFirstName: "Mark", strLastName: "Taylor"),
                PaymentModel(intCardNumber: 4555555555555555, strMonth: "05", strYear: "2030", intSecurityCode: 654, strFirstName: "Emily", strLastName: "Clark")
            ]
        }
}
