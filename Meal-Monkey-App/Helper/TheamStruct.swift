//
//  TheamStruct.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 10/09/25.
//
import UIKit

struct Theme {
    let name: String
    let mainColor: UIColor  // Primary buttons, highlights
    let accentColor: UIColor  // Secondary accents
    let backgroundColor: UIColor  // App background
    let primaryFontColor: UIColor  // Titles, main text
    let secondaryFontColor: UIColor  // Subtitles, secondary text
    let placeholderColor: UIColor  // TextField placeholders
    let cellBackgroundColor: UIColor  // TableView / cell backgrounds
    let buttonColor: UIColor  // All buttons (star, normal buttons)
    let labelColor: UIColor  // General labels (optional, override primary if needed)
    let titleColor: UIColor  // Titles (override primaryFontColor if needed)
    let borderColor: UIColor
    let iconTintColor: UIColor  // for heart and stars
    let buttonTitle: UIColor
}

struct MainTheme {
    struct themes {

        static let defaultApp = Theme(
            name: "Default",
            mainColor: UIColor(hex: "#FC6011"),  // All buttons
            accentColor: UIColor(hex: "#367FC0"),  // Facebook btn
            backgroundColor: UIColor(hex: "#FFFFFF"),  // App background (default white)
            primaryFontColor: UIColor(hex: "#4A4B4D"),  // Main label
            secondaryFontColor: UIColor(hex: "#7C7D7E"),  // Sub label
            placeholderColor: UIColor(hex: "#B6B7B7"),  // Placeholder
            cellBackgroundColor: UIColor(hex: "#F6F6F6"),  // Cell bg
            buttonColor: UIColor(hex: "#FC6011"),  // All buttons
            labelColor: UIColor(hex: "#4A4B4D"),  // General label
            titleColor: UIColor(hex: "#4A4B4D"),  // Navigation bar label
            borderColor: .lightGray,
            iconTintColor: UIColor(hex: "#FC6011"),
            buttonTitle: .white  // Icons
        )

        static let lavenderSand = Theme(
            name: "Lavender & Sand",
            mainColor: UIColor(hex: "#9B59B6"),
            accentColor: UIColor(hex: "#F5E6CC"),
            backgroundColor: UIColor(hex: "#FFFFFF"),
            primaryFontColor: UIColor(hex: "#4A4B4D"),
            secondaryFontColor: UIColor(hex: "#7C7D7E"),
            placeholderColor: UIColor(hex: "#B6B7B7"),
            cellBackgroundColor: UIColor(hex: "#FFFFFF"),
            buttonColor: UIColor(hex: "#9B59B6"),
            labelColor: UIColor(hex: "#4A4B4D"),
            titleColor: UIColor(hex: "#4A4B4D"),
            borderColor: .gray,
            iconTintColor: UIColor(hex: "#9B59B6"),
            buttonTitle: .black
        )

        static let peachTeal = Theme(
            name: "Peach & Teal",
            mainColor: UIColor(hex: "#1ABC9C"),
            accentColor: UIColor(hex: "#FFD9B3"),
            backgroundColor: UIColor(hex: "#FFF5F0"),
            primaryFontColor: UIColor(hex: "#1A1A1A"),
            secondaryFontColor: UIColor(hex: "#7C7D7E"),
            placeholderColor: UIColor(hex: "#B6B7B7"),
            cellBackgroundColor: UIColor(hex: "#FFF5F0"),
            buttonColor: UIColor(hex: "#1ABC9C"),
            labelColor: UIColor(hex: "#1A1A1A"),
            titleColor: UIColor(hex: "#1A1A1A"),
            borderColor: .gray,
            iconTintColor: UIColor(hex: "#1ABC9C"),
            buttonTitle: .black
        )

        static let mustardSlate = Theme(
            name: "Mustard & Slate",
            mainColor: UIColor(hex: "#F1C40F"),
            accentColor: UIColor(hex: "#D1D5DB"),
            backgroundColor: UIColor(hex: "#FFFFFF"),
            primaryFontColor: UIColor(hex: "#2C2C2C"),
            secondaryFontColor: UIColor(hex: "#7C7D7E"),
            placeholderColor: UIColor(hex: "#B6B7B7"),
            cellBackgroundColor: UIColor(hex: "#FFFFFF"),
            buttonColor: UIColor(hex: "#F1C40F"),
            labelColor: UIColor(hex: "#2C2C2C"),
            titleColor: UIColor(hex: "#2C2C2C"),
            borderColor: .gray,
            iconTintColor: UIColor(hex: "#F1C40F"),
            buttonTitle: .white

        )

        static let mintSandstone = Theme(
            name: "Mint & Sandstone",
            mainColor: UIColor(hex: "#3EB489"),
            accentColor: UIColor(hex: "#F0E2D6"),
            backgroundColor: UIColor(hex: "#F0FFF4"),
            primaryFontColor: UIColor(hex: "#4A4B4D"),
            secondaryFontColor: UIColor(hex: "#7C7D7E"),
            placeholderColor: UIColor(hex: "#B6B7B7"),
            cellBackgroundColor: UIColor(hex: "#F0FFF4"),
            buttonColor: UIColor(hex: "#3EB489"),
            labelColor: UIColor(hex: "#4A4B4D"),
            titleColor: UIColor(hex: "#4A4B4D"),
            borderColor: .gray,
            iconTintColor: UIColor(hex: "#3EB489"),
            buttonTitle: .white

        )

        static let plumLemon = Theme(
            name: "Plum & Lemon",
            mainColor: UIColor(hex: "#7D3C98"),
            accentColor: UIColor(hex: "#FFF176"),
            backgroundColor: UIColor(hex: "#FFFFFF"),
            primaryFontColor: UIColor(hex: "#1A1A1A"),
            secondaryFontColor: UIColor(hex: "#7C7D7E"),
            placeholderColor: UIColor(hex: "#B6B7B7"),
            cellBackgroundColor: UIColor(hex: "#FFFFFF"),
            buttonColor: UIColor(hex: "#7D3C98"),
            labelColor: UIColor(hex: "#1A1A1A"),
            titleColor: UIColor(hex: "#1A1A1A"),
            borderColor: .gray,
            iconTintColor: UIColor(hex: "#7D3C98"),
            buttonTitle: .black

        )
    }
}

// MARK: - UIColor Hex Init
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255
        let b = CGFloat(rgb & 0x0000FF) / 255
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}
