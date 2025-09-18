//
//  LanguageDelegate.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/09/25.
//

import Foundation
import UIKit

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return commonData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell: LanguageTableViewCell =
            tableView.dequeueReusableCell(
                withIdentifier: Main.CellIdentifier.LanguageTableViewCell,
                for: indexPath
            ) as! LanguageTableViewCell

        switch selected {
        case .language:
            let obj = commonData[indexPath.row]
            cell.configLanguage(lang: obj, selectedTag: selectedLanguageTag)

        case .theme:
            let obj = commonData[indexPath.row]
            cell.configTheme(theme: obj, selectedThemeTag: selectedThemeTag)
        }
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let obj = commonData[indexPath.row]

        switch selected {
        case .language:
            selectedLanguageTag = obj.inTag

            var langCode = "en"
            switch obj.inTag {
            case 0: langCode = "en"
            case 1: langCode = "mr"
            case 2: langCode = "hi"
            case 3: langCode = "gu"
            case 4: langCode = "ta"
            case 5: langCode = "ur"
            default: langCode = "en"
            }

            // Update LocalizationManager
            LocalizationManager.shared.setLanguage(langCode)

            // Post notification for language change
            NotificationCenter.default.post(name: .languageChanged, object: nil)

        case .theme:
            selectedThemeTag = obj.inTag

            switch obj.inTag {
            case 0: ThemeManager.currentTheme = MainTheme.themes.defaultApp
            case 1: ThemeManager.currentTheme = MainTheme.themes.lavenderSand
            case 2: ThemeManager.currentTheme = MainTheme.themes.peachTeal
            case 3: ThemeManager.currentTheme = MainTheme.themes.mustardSlate
            case 4: ThemeManager.currentTheme = MainTheme.themes.mintSandstone
            case 5: ThemeManager.currentTheme = MainTheme.themes.plumLemon
            default: ThemeManager.currentTheme = MainTheme.themes.defaultApp
            }
        }
        tableView.reloadData()  // update checkmarks
    }
}
