//
//  AppThemeHelper.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 07/09/25.
//

import Foundation

struct ThemeManager {
    static var currentTheme: Theme {
        get {
            let themeName =
                UserDefaults.standard.string(forKey: "selectedTheme")
                ?? "defaultApp"
            switch themeName {
            case "defaultApp": return MainTheme.themes.defaultApp
            case "peachTeal": return MainTheme.themes.peachTeal
            case "mustardSlate": return MainTheme.themes.mustardSlate
            case "mintSandstone": return MainTheme.themes.mintSandstone
            case "plumLemon": return MainTheme.themes.plumLemon
            case "lavenderSand": return MainTheme.themes.lavenderSand
            default: return MainTheme.themes.defaultApp  // fallback
            }
        }
        set {
            let name: String
            if newValue.name == MainTheme.themes.defaultApp.name {
                name = "defaultApp"
            } else if newValue.name == MainTheme.themes.peachTeal.name {
                name = "peachTeal"
            } else if newValue.name == MainTheme.themes.mustardSlate.name {
                name = "mustardSlate"
            } else if newValue.name == MainTheme.themes.mintSandstone.name {
                name = "mintSandstone"
            } else if newValue.name == MainTheme.themes.plumLemon.name {
                name = "plumLemon"
            } else {
                name = "lavenderSand"
            }

            UserDefaults.standard.set(name, forKey: "selectedTheme")
            NotificationCenter.default.post(
                name: NSNotification.Name("themeChanged"),
                object: nil
            )
        }
    }
}

enum ThemeName: String {
    case lavenderSand, peachTeal, mustardSlate, mintSandstone, plumLemon
}
