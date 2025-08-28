//
//  Pass + Email + Extension.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import Foundation
import UIKit

/**
 An extension to `String` to provide common validation methods for emails and passwords.
 These computed properties simplify the process of validating user input against predefined regular expressions.
 */
extension String {
    /// A computed property that returns `true` if the string is a valid password, otherwise `false`.
    /// A valid password must be at least 8 characters long and contain at least one uppercase letter,
    /// one lowercase letter, one number, and one special character.
    var isValidPassword: Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: self)
    }
    
    /// A computed property that returns `true` if the string is a valid email, otherwise `false`.
    /// The validation is performed on a trimmed version of the string to ignore leading and trailing whitespace.
    var isValidEmail: Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: trimmed)
    }
}
