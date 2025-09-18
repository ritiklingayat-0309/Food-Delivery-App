//
//  LanguageViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 06/09/25.
//

import UIKit

class LanguageViewController: UIViewController {

    var selected: SelectType = .language
    var commonData: [SettingsModel] = []
    var selectedLanguageTag: Int = 0  // default English
    var selectedThemeTag: Int = 0
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(
            UINib(
                nibName: Main.CellIdentifier.LanguageTableViewCell,
                bundle: nil
            ),
            forCellReuseIdentifier: Main.CellIdentifier.LanguageTableViewCell
        )

        switch selected {
        case .language:
            commonData = SettingsModel.availableLanguages()
            let currentLang = LocalizationManager.shared.currentLanguage
            selectedLanguageTag = currentLangTag(for: currentLang)
            self.setLeftAlignedTitleWithBack(
                "Language",
                target: self,
                action: #selector(backButtonTapped)
            )

        case .theme:
            commonData = SettingsModel.availableThemes()

            let savedTheme =
                UserDefaults.standard.string(forKey: "selectedTheme")
                ?? "defaultApp"
            switch savedTheme {
            case "defaultApp": selectedThemeTag = 0
            case "lavenderSand": selectedThemeTag = 1
            case "peachTeal": selectedThemeTag = 2
            case "mustardSlate": selectedThemeTag = 3
            case "mintSandstone": selectedThemeTag = 4
            case "plumLemon": selectedThemeTag = 5
            default: selectedThemeTag = 0
            }

            self.setLeftAlignedTitleWithBack(
                "Theme",
                target: self,
                action: #selector(backButtonTapped)
            )
        }

    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    private func currentLangTag(for langCode: String) -> Int {
        switch langCode {
        case "en": return 0
        case "mr": return 1
        case "hi": return 2
        case "gu": return 3
        case "ta": return 4
        case "ur": return 5
        default: return 0
        }
    }
}

enum SelectType {
    case language
    case theme
}
