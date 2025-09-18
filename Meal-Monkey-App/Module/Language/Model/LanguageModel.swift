//
//  LanguageModel.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/09/25.
//

import Foundation

class SettingsModel {
    var lang: String?
    var theme: String?
    let inTag: Int

    init(lang: String? = nil, theme: String? = nil, inTag: Int = 0) {
        self.lang = lang
        self.theme = theme
        self.inTag = inTag
    }

    // MARK: - Languages
    class func availableLanguages() -> [SettingsModel] {
        return [
            SettingsModel(lang: Main.Language.english, inTag: 0),
            SettingsModel(lang: Main.Language.marathi, inTag: 1),
            SettingsModel(lang: Main.Language.hindi, inTag: 2),
            SettingsModel(lang: Main.Language.gujrati, inTag: 3),
            SettingsModel(lang: Main.Language.tamil, inTag: 4),
            SettingsModel(lang: Main.Language.urdu, inTag: 5),
        ]
    }

    // MARK: - Themes
    class func availableThemes() -> [SettingsModel] {
        return [
            SettingsModel(theme: MainTheme.themes.defaultApp.name, inTag: 0),  // Default
            SettingsModel(theme: MainTheme.themes.lavenderSand.name, inTag: 1),
            SettingsModel(theme: MainTheme.themes.peachTeal.name, inTag: 2),
            SettingsModel(theme: MainTheme.themes.mustardSlate.name, inTag: 3),
            SettingsModel(theme: MainTheme.themes.mintSandstone.name, inTag: 4),
            SettingsModel(theme: MainTheme.themes.plumLemon.name, inTag: 5),
        ]
    }
}
