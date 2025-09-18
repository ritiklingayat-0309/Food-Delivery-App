//
//  LocalizationManager.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/09/25.
//

import Foundation

class LocalizationManager {

    static let shared = LocalizationManager()

    private var bundle: Bundle? = nil
    private(set) var currentLanguage: String = "en"

    private init() {
        // Load saved language, fallback to English
        if let savedLang = UserDefaults.standard.string(forKey: "AppLanguage") {
            setLanguage(savedLang, isFirstLaunch: true)
        } else {
            setLanguage("en", isFirstLaunch: true)
        }
    }

    /// Set app language
    func setLanguage(_ langCode: String, isFirstLaunch: Bool = false) {
        currentLanguage = langCode

        // Save to UserDefaults
        UserDefaults.standard.set(langCode, forKey: "AppLanguage")
        UserDefaults.standard.synchronize()

        // Load proper bundle
        if let path = Bundle.main.path(forResource: langCode, ofType: "lproj") {
            bundle = Bundle(path: path)
        } else {
            bundle = Bundle.main
        }

        if !isFirstLaunch {
            print("🔄 Language changed to: \(langCode)")
        }
    }

    /// Fetch localized string
    func localizedString(forKey key: String) -> String {
        return bundle?.localizedString(forKey: key, value: nil, table: nil)
            ?? key
    }
}
