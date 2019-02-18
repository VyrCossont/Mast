//
//  Theme.swift
//  mastodon
//
//  Created by Vyr Cossont on 2/11/19.
//  Copyright © 2019 Vyr Cossont. All rights reserved.
//

import Foundation
import UIKit

/// Extracts some of the most heavily duplicated theming code from the view controllers.
class Theme {

    /// Called in the loadLoadLoad() method of most view controllers to copy the current theme to static vars in Colours,
    /// which are then referenced by the view controllers themselves to apply the theme to views.
    static func setThemeGlobalsFromUserSettings() {
        setFontSizeGlobalsFromUserSettings()
        setColorGlobalsFromUserSettings()
    }

    /// Copy current theme colors to static vars in Colours.
    private static func setColorGlobalsFromUserSettings() {
        let themeColors = UserDefaults.theme.colors
        Colours.black = themeColors.text
        Colours.grayDark = themeColors.textAlt
        Colours.grayDark2 = themeColors.textAlt2
        Colours.cellQuote = themeColors.cellQuote
        Colours.tabUnselected = themeColors.tabUnselected
        Colours.white = themeColors.background
        Colours.white3 = themeColors.backgroundAlt
        UIApplication.shared.statusBarStyle = UserDefaults.theme.statusBarStyle
    }

    /// Copy current theme font sizes to static vars in Colours.
    /// Note that the system font size preference takes precedence over an explicitly set font size.
    private static func setFontSizeGlobalsFromUserSettings() {
        Colours.fontSize1 = titleFontSize
        Colours.fontSize3 = textFontSize
    }
    
    static var titleFontSize: CGFloat {
        get {
            if (UserDefaults.systemText) {
                return CGFloat(UIFont.systemFontSize)
            } else {
                return CGFloat(UserDefaults.fontSize + 4)
            }
        }
    }
    
    static var textFontSize: CGFloat {
        get {
            if (UserDefaults.systemText) {
                return CGFloat(UIFont.smallSystemFontSize)
            } else {
                return CGFloat(UserDefaults.fontSize)
            }
        }
    }
}

enum NamedTheme: Int, CaseIterable {
    case day
    case dusk
    case night
    case midnight
    case midnightBlue
    
    var name: String {
        let value: String
        switch self {
        case .day:
            value = "Day"
        case .dusk:
            value = "Dusk"
        case .night:
            value = "Night"
        case .midnight:
            value = "Midnight"
        case .midnightBlue:
            value = "Midnight Blue"
        }
        return value
    }
    
    var notificationName: Notification.Name {
        let value: String
        switch self {
        case .day:
            value = "light"
        case .dusk:
            value = "night"
        case .night:
            value = "night2"
        case .midnight:
            value = "black"
        case .midnightBlue:
            value = "midblue"
        }
        return NSNotification.Name(rawValue: value)
    }
    
    init?(notificationName: Notification.Name) {
        for namedTheme in NamedTheme.allCases {
            if notificationName == namedTheme.notificationName {
                self = namedTheme
            }
        }
        return nil
    }
    
    var urlHost: String {
        switch self {
        case .day:
            return "light"
        case .dusk:
            return "dark"
        case .night:
            return "darker"
        case .midnight:
            return "black"
        case .midnightBlue:
            return "blue"
        }
    }
    
    init?(urlHost: String) {
        for namedTheme in NamedTheme.allCases {
            if urlHost == namedTheme.urlHost {
                self = namedTheme
            }
        }
        return nil
    }
    
    var activityType: String {
        let value: String
        switch self {
        case .day:
            value = "light"
        case .dusk:
            value = "dark"
        case .night:
            value = "dark2"
        case .midnight:
            value = "oled"
        case .midnightBlue:
            value = "bluemid"
        }
        return "com.shi.Mast.\(value)"
    }
    
    init?(activityType: String) {
        for namedTheme in NamedTheme.allCases {
            if activityType == namedTheme.activityType {
                self = namedTheme
            }
        }
        return nil
    }
    
    var activityTitle: String {
        let value: String
        switch self {
        case .day:
            value = "Switch to light mode"
        case .dusk:
            value = "Switch to dark mode"
        case .night:
            value = "Switch to extra dark mode"
        case .midnight:
            value = "Switch to true black dark mode"
        case .midnightBlue:
            value = "Switch to midnight blue mode"
        }
        return value
    }

    var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .day:
            return .default
        default:
            return .lightContent
        }
    }
    
    var keyboardAppearance: UIKeyboardAppearance {
        switch self {
        case .day:
            return .light
        default:
            return .dark
        }
    }
    
    var colors: NamedThemeColors {
        switch self {
        case .day:
            return NamedThemeColors(
                text: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                textAlt: #colorLiteral(red: 0.160000, green: 0.160000, blue: 0.160000, alpha: 1.000000),
                textAlt2: #colorLiteral(red: 0.440000, green: 0.452000, blue: 0.484000, alpha: 1.000000),
                cellQuote: #colorLiteral(red: 0.952941, green: 0.949020, blue: 0.964706, alpha: 1.000000),
                tabUnselected: #colorLiteral(red: 0.882353, green: 0.882353, blue: 0.882353, alpha: 1.000000),
                background: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                backgroundAlt: #colorLiteral(red: 0.921569, green: 0.921569, blue: 0.921569, alpha: 1.000000)
            )
        case .dusk:
            return NamedThemeColors(
                text: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                textAlt: #colorLiteral(red: 1.000000, green: 1.000000, blue: 1.000000, alpha: 1.000000),
                textAlt2: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                cellQuote: #colorLiteral(red: 0.129412, green: 0.129412, blue: 0.168627, alpha: 1.000000),
                tabUnselected: #colorLiteral(red: 0.313725, green: 0.313725, blue: 0.352941, alpha: 1.000000),
                background: #colorLiteral(red: 0.207843, green: 0.207843, blue: 0.250980, alpha: 1.000000),
                backgroundAlt: #colorLiteral(red: 0.129412, green: 0.129412, blue: 0.172549, alpha: 1.000000)
            )
        case .night:
            return NamedThemeColors(
                text: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                textAlt: #colorLiteral(red: 1.000000, green: 1.000000, blue: 1.000000, alpha: 1.000000),
                textAlt2: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                cellQuote: #colorLiteral(red: 0.129412, green: 0.129412, blue: 0.168627, alpha: 1.000000),
                tabUnselected: #colorLiteral(red: 0.313725, green: 0.313725, blue: 0.352941, alpha: 1.000000),
                background: #colorLiteral(red: 0.141176, green: 0.129412, blue: 0.145098, alpha: 1.000000),
                backgroundAlt: #colorLiteral(red: 0.062745, green: 0.050980, blue: 0.066667, alpha: 1.000000)
            )
        case .midnight:
            return NamedThemeColors(
                text: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                textAlt: #colorLiteral(red: 1.000000, green: 1.000000, blue: 1.000000, alpha: 1.000000),
                textAlt2: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                cellQuote: #colorLiteral(red: 0.117647, green: 0.117647, blue: 0.117647, alpha: 1.000000),
                tabUnselected: #colorLiteral(red: 0.274510, green: 0.274510, blue: 0.313725, alpha: 1.000000),
                background: #colorLiteral(red: 0.000000, green: 0.000000, blue: 0.000000, alpha: 1.000000),
                backgroundAlt: #colorLiteral(red: 0.117647, green: 0.133333, blue: 0.149020, alpha: 1.000000)
            )
        case .midnightBlue:
            return NamedThemeColors(
                text: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                textAlt: #colorLiteral(red: 1.000000, green: 1.000000, blue: 1.000000, alpha: 1.000000),
                textAlt2: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                cellQuote: #colorLiteral(red: 0.078431, green: 0.078431, blue: 0.113725, alpha: 1.000000),
                tabUnselected: #colorLiteral(red: 0.313725, green: 0.313725, blue: 0.352941, alpha: 1.000000),
                background: #colorLiteral(red: 0.031373, green: 0.109804, blue: 0.345098, alpha: 1.000000),
                backgroundAlt: #colorLiteral(red: 0.000000, green: 0.054902, blue: 0.270588, alpha: 1.000000)
            )
        }
    }
}

/// List of colors that can be changed by a theme.
struct NamedThemeColors {
    /// Colours.black
    let text: UIColor
    /// Colours.grayDark
    let textAlt: UIColor
    /// Colours.grayDark2
    let textAlt2: UIColor
    /// Colors.cellQuote
    let cellQuote: UIColor
    /// Colours.tabUnselected
    let tabUnselected: UIColor
    /// Colours.white
    let background: UIColor
    /// Colours.white3
    let backgroundAlt: UIColor
}

/// Convenience user settings extensions related to theming.
extension UserDefaults {
    
    private static let systemTextKey = "systemText"

    /// Use system text sizes instead of an explicitly set size.
    /// Note that this is on by default, and a stored value of 1 or true means this feature is *off*.
    static var systemText: Bool {
        get {
            return !UserDefaults.standard.bool(forKey: systemTextKey)
        }
        set {
            UserDefaults.standard.set(!newValue, forKey: systemTextKey)
        }
    }
    
    private static let fontSizeKey = "fontSize"
    static let fontSizeMin = 8
    static let fontSizeMax = 14

    /// Use explicit font sizes rather than using system font sizes.
    /// Refers to the body text font size; the title font size is currently always 4 points larger.
    /// Stored value is the point size as an int - 8. Default value if not set is 10pt.
    static var fontSize: Int {
        get {
            return fontSizeMin + (UserDefaults.standard.object(forKey: fontSizeKey) as? Int ?? 2)
        }
        set {
            guard newValue >= fontSizeMin else {
                print("Can't set \(fontSizeKey) to \(newValue); it's smaller than the minimum of \(fontSizeMin)!")
                return
            }
            UserDefaults.standard.set(newValue - fontSizeMin, forKey: fontSizeKey)
        }
    }
    
    private static let themeKey = "theme"
    
    /// The user's theme. The default is day.
    static var theme: NamedTheme {
        get {
            return NamedTheme(rawValue: UserDefaults.standard.integer(forKey: themeKey)) ?? .day
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: themeKey)
        }
    }
}
