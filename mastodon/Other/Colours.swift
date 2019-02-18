//
//  Colours.swift
//  CosmoCast
//
//  Created by Shihab Mehboob on 18/09/2018.
//  Copyright © 2018 Shihab Mehboob. All rights reserved.
//

import Foundation
import UIKit

/// Mutable global variables used for font sizes and theme colors.
/// See Theme, NamedTheme, NameThemeColors, loadLoadLoad(), changeTheme() methods.
/// Set *initially* here but updated from elsewhere whenever the theme changes.
struct Colours {
    
    static var fontSize1 = Theme.titleFontSize
    static var fontSize3 = Theme.textFontSize
    
    static var keyCol = UserDefaults.theme.keyboardAppearance
    
    // MARK: theme text colors
    static var black = UserDefaults.theme.colors.text
    static var grayDark = UserDefaults.theme.colors.textAlt
    static var grayDark2 = UserDefaults.theme.colors.textAlt2
    
    // MARK: theme background colors
    static var white = UserDefaults.theme.colors.background
    static var white3 = UserDefaults.theme.colors.backgroundAlt
    
    // MARK: other theme colors
    static var cellQuote = UserDefaults.theme.colors.cellQuote
    static var tabUnselected = UserDefaults.theme.colors.tabUnselected
    
    // MARK: colors that were probably meant to be themeable but aren't currently
    static var tabSelected = #colorLiteral(red: 0.419608, green: 0.478431, blue: 0.839216, alpha: 1.000000)
    static var tabSelected2 = #colorLiteral(red: 0.317647, green: 0.388235, blue: 0.780392, alpha: 1.000000)
    static var grayDark3 = #colorLiteral(red: 0.060000, green: 0.072000, blue: 0.104000, alpha: 1.000000)
    static var grayLight19 = #colorLiteral(red: 0.440000, green: 0.452000, blue: 0.484000, alpha: 1.000000)
    static var grayLight2 = #colorLiteral(red: 0.300000, green: 0.312000, blue: 0.340000, alpha: 1.000000)
    
    // MARK: non-themeable colors
    static let gray = #colorLiteral(red: 0.784314, green: 0.784314, blue: 0.784314, alpha: 1.000000)
    static let red = #colorLiteral(red: 1.000000, green: 0.329412, blue: 0.329412, alpha: 1.000000)
    static let purple = #colorLiteral(red: 0.403922, green: 0.462745, blue: 0.780392, alpha: 1.000000)
    static let green = #colorLiteral(red: 0.392157, green: 0.823529, blue: 0.431373, alpha: 1.000000)
}
