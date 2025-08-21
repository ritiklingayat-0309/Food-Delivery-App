//
//  Card Data helper.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 21/08/25.
//

//
//  Card Data helper.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 21/08/25.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    // MARK: - Properties
    static let shared = CoreDataManager()
    
    // **Change:** Remove the redundant Core Data stack
    // The Core Data stack should be managed by AppDelegate
    
    // MARK: - Core Data Context
    
    // **Change:** Use the managed context from the AppDelegate's persistent container
    var managedContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Helper Methods
    
    /// Fetches the currently logged-in user from Core Data.
    /// - Returns: The `User` object for the logged-in user, or `nil` if not found.
    func getLoggedInUser() -> User? {
        guard let loggedInUserIDString = UserDefaults.standard.string(forKey: "loggedInUserID"),
              let loggedInUserID = UUID(uuidString: loggedInUserIDString) else {
            print("No logged-in user found in UserDefaults.")
            return nil
        }
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userID == %@", loggedInUserID as CVarArg)
        
        do {
            let users = try managedContext.fetch(fetchRequest)
            return users.first
        } catch let error as NSError {
            print("Could not fetch user. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    /// Saves a new payment detail for the logged-in user.
    func savePaymentDetails(cardNumber: String, securityCode: String, firstName: String, lastName: String, expiryMonth: String, expiryYear: String) {
        
        guard let user = getLoggedInUser() else {
            print("Error: No logged-in user to associate with payment details.")
            return
        }
        
        let paymentDetail = PaymentDetails(context: managedContext)
        paymentDetail.cardNumber = Int32(cardNumber) ?? 0
        paymentDetail.securityCode = Int32(securityCode) ?? 0
        paymentDetail.firstName = firstName
        paymentDetail.lastName = lastName
        paymentDetail.expiryMonth = expiryMonth
        paymentDetail.expiryYear = expiryYear
        paymentDetail.userID = user.userID
        paymentDetail.user = user
        
        do {
            try managedContext.save()
            print("Payment details saved successfully.")
        } catch let error as NSError {
            print("Could not save payment details. \(error), \(error.userInfo)")
        }
    }
    
    /// Fetches all payment details for the logged-in user.
    /// - Returns: An array of `PaymentDetails` objects.
    func fetchPaymentDetails() -> [PaymentDetails] {
        guard let user = getLoggedInUser() else {
            return []
        }
        
        let fetchRequest: NSFetchRequest<PaymentDetails> = PaymentDetails.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "user == %@", user)
        
        do {
            let paymentDetails = try managedContext.fetch(fetchRequest)
            return paymentDetails
        } catch let error as NSError {
            print("Could not fetch payment details. \(error), \(error.userInfo)")
            return []
        }
    }
    
    /// Deletes a payment detail object from Core Data.
    /// - Parameter paymentDetail: The `PaymentDetails` object to delete.
    func deletePaymentDetail(_ paymentDetail: PaymentDetails) {
        managedContext.delete(paymentDetail)
        do {
            try managedContext.save()
            print("Payment details deleted successfully.")
        } catch let error as NSError {
            print("Could not delete payment details. \(error), \(error.userInfo)")
        }
    }
}
