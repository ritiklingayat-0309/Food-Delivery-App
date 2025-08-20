//
//
//  UserDefaults+Extensions.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/08/25.
//

import Foundation

extension UserDefaults {
    
    /// The key used to store payment card data.
    private enum Keys {
        static let savedPaymentCards = "savedPaymentCards"
    }
    
    /// Saves the shared payment cards array to UserDefaults.
    func savePaymentCards(_ cards: [[String: String]]) {
        do {
            let encodedData = try JSONEncoder().encode(cards)
            set(encodedData, forKey: Keys.savedPaymentCards)
            print("Payment cards saved to UserDefaults.")
        } catch {
            print("Failed to save payment cards: \(error.localizedDescription)")
        }
    }
    
    /// Loads the shared payment cards array from UserDefaults.
    func loadPaymentCards() -> [[String: String]] {
        if let savedData = data(forKey: Keys.savedPaymentCards) {
            do {
                let decodedCards = try JSONDecoder().decode([[String: String]].self, from: savedData)
                print("Payment cards loaded from UserDefaults.")
                return decodedCards
            } catch {
                print("Failed to load payment cards: \(error.localizedDescription)")
            }
        }
        return [] // Return an empty array if loading fails
    }
}
