//
//  Pass + Email + Extension.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/08/25.
//

import Foundation
import UIKit

//for email and password validation
extension String {
    var isValidPassword: Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: trimmed)
    }
}
