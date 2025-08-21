//
//  Key-chain-helper.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 18/08/25.
//

import Security
import Foundation

/**
 A helper class for securely storing and retrieving data from the Keychain.
 The Keychain is a secure, encrypted storage for small bits of user data
 like passwords, tokens, and certificates. This class provides a simple API
 to interact with the Keychain for generic password items.
 */
class KeychainHelper {
    
    /**
     Saves a string value to the Keychain with a specified key.
     This method will first attempt to delete any existing item with the same key
     before saving the new one, ensuring that the value is always up-to-date.
     - Parameters:
     - key: The unique key used to identify the item in the Keychain.
     - value: The string value to be stored securely.
     */
    class func save(key: String, value: String) {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]
            SecItemDelete(query as CFDictionary) // Remove old value
            SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    /**
     Retrieves a string value from the Keychain using a specified key.
     - Parameter key: The unique key associated with the item.
     - Returns: The string value stored in the Keychain, or `nil` if the item is not found.
     */
    class func get(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    /**
     Deletes an item from the Keychain using its key.
     - Parameter key: The unique key of the item to be deleted.
     */
    class func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
