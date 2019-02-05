//
//  RichText.swift
//  mastodon
//
//  Created by Vyr Cossont on 2/2/19.
//  Copyright © 2019 Vyr Cossont. All rights reserved.
//

import Foundation
import HTMLEntities
import SwiftSoup

/// Support class for the String extension below.
final class RichText {
    fileprivate static let whitelistBasic = try! Whitelist.basic()
    fileprivate static let whitelistExtra = try! whitelistBasic
        .addTags("h1", "h2", "h3", "h4", "h5", "h6")
    
    fileprivate static let internalEncoding = String.Encoding.utf8
    
    /// See https://mathiasbynens.be/notes/css-escapes _at least_.
    fileprivate static func cssStringEscape(_ string: String) -> String {
        return "\"\(string.replacingOccurrences(of: "\"", with: "\\\""))\""
    }
    
    /// DEBUG(Vyr): should obviously do something else if this happens
    static let failure = NSAttributedString(string: "⚠️ RICH TEXT FAILURE")
    
    static func settingsDefault() -> RichTextSettings {
        return RichTextSettings()
    }
    
    static func settingsDefaultSubtle() -> RichTextSettings {
        return RichTextSettings(
            textColor: Colours.black.withAlphaComponent(0.3),
            linkColor: Colours.tabSelected.withAlphaComponent(0.3)
        )
    }
    
    static func settingsFollowers() -> RichTextSettings {
        return RichTextSettings(
            bodyFont: UIFont.systemFont(ofSize: Colours.fontSize3),
            textColor: Colours.black.withAlphaComponent(0.6),
            linkColor: Colours.tabSelected.withAlphaComponent(0.6)
        )
    }
    
    static func settingsDisplayName() -> RichTextSettings {
        return RichTextSettings(
            whitelist: RichText.whitelistBasic,
            bodyFont: UIFont.boldSystemFont(ofSize: Colours.fontSize1)
        )
    }
    
    static func settingsDisplayNameSubtle() -> RichTextSettings {
        return RichTextSettings(
            whitelist: RichText.whitelistBasic,
            bodyFont: UIFont.boldSystemFont(ofSize: Colours.fontSize1),
            textColor: Colours.black.withAlphaComponent(0.3),
            linkColor: Colours.tabSelected.withAlphaComponent(0.3)
        )
    }
    
    static func settingsProfile() -> RichTextSettings {
        return RichTextSettings(
            bodyFont: UIFont.boldSystemFont(ofSize: 14),
            textColor: UIColor.white,
            linkColor: UIColor.white.withAlphaComponent(0.7),
            textAlign: .center
        )
    }
    
    static func settingsDisplayNameProfile() -> RichTextSettings {
        return RichTextSettings(
            bodyFont: UIFont.systemFont(ofSize: 16, weight: .heavy),
            textColor: UIColor.white,
            linkColor: UIColor.white.withAlphaComponent(0.7)
        )
    }
}

class RichTextSettings {
    let whitelist: Whitelist
    let bodyFont: UIFont
    let textColor: UIColor
    let linkColor: UIColor
    let textAlign: NSTextAlignment
    
    required init(
        whitelist: Whitelist = RichText.whitelistExtra,
        bodyFont: UIFont = UIFont.systemFont(ofSize: Colours.fontSize1),
        textColor: UIColor = Colours.black,
        linkColor: UIColor = Colours.tabSelected,
        textAlign: NSTextAlignment = .natural)
    {
        self.whitelist = whitelist
        self.bodyFont = bodyFont
        self.textColor = textColor
        self.linkColor = linkColor
        self.textAlign = textAlign
    }
}

extension Status {
    func asRichText(
        _ settings: RichTextSettings = RichText.settingsDefault(),
        suffix: String? = nil)
        -> NSAttributedString?
    {
        return self.content.cleanRich(
            settings,
            emojis: self.emojis,
            htmlSuffix: suffix.map { x in "<p>\(x.htmlEscape())</p>" }
        )
    }
}

extension Account {
    func displayNameAsRichText(
        _ settings: RichTextSettings = RichText.settingsDisplayName(),
        suffix: String? = nil)
        -> NSAttributedString?
    {
        // TODO(Vyr): display name whitelist should have basically nothing in it
        return self.displayName.cleanRich(
            settings,
            emojis: self.emojis,
            htmlSuffix: suffix.map { $0.htmlEscape() }
        )
    }

    // TODO(Vyr): create proper type for clean/format settings.
    func noteAsRichText(
        _ settings: RichTextSettings = RichText.settingsDefault())
        -> NSAttributedString?
    {
        return self.note.cleanRich(
            settings,
            emojis: self.emojis
        )
    }
}

/// Add methods to turn an HTML string into an attributed string.
extension String {
    /// Translate some acceptable subset of HTML into an attributed string.
    /// Allow HTML tags corresponding (approximately) to what Markdown allows.
    /// See https://cocoapods.org/pods/SwiftSoup#sanitize-untrusted-html-to-prevent-xss
    func cleanRich(
        _ settings: RichTextSettings,
        emojis: [Emoji] = [],
        htmlSuffix: String? = nil)
        -> NSAttributedString?
    {
        // Initialize with fallback white.
        var textRed: CGFloat = 1.0
        var textGreen: CGFloat = 1.0
        var textBlue: CGFloat = 1.0
        var textAlpha: CGFloat = 1.0
        let textColorBreakdownSuccess = settings.textColor.getRed(&textRed, green: &textGreen, blue: &textBlue, alpha: &textAlpha)
        if (!textColorBreakdownSuccess) {
            print("RichText: couldn't convert textColor to RGBA: \(settings.textColor)")
        }

        // Initialize with fallback blue.
        var linkRed: CGFloat = 0.0
        var linkGreen: CGFloat = 0.0
        var linkBlue: CGFloat = 1.0
        var linkAlpha: CGFloat = 1.0
        let linkColorBreakdownSuccess = settings.linkColor.getRed(&linkRed, green: &linkGreen, blue: &linkBlue, alpha: &linkAlpha)
        if (!linkColorBreakdownSuccess) {
            print("RichText: couldn't convert linkColor to RGBA: \(settings.linkColor)")
        }

        let styleAlign: String
        switch settings.textAlign {
        case .natural:
            styleAlign = ""
        default:
            styleAlign = "text-align: \(RichText.cssStringEscape(String(describing: settings.textAlign)))"
        }
        
        // Yes, CSS RGB values are either 0-255 or 0%-100% while alpha values are floats.
        // Try not to think about it too hard.
        let styleStart = """
            <html><head><style>
            body {
                font-size: \(settings.bodyFont.pointSize)pt;
                font-family: \(RichText.cssStringEscape(settings.bodyFont.familyName));
                color: rgba(\(Int(textRed * 100))%, \(Int(textGreen * 100))%, \(Int(textBlue * 100))%, \(textAlpha));
                \(styleAlign)
            }
            a {
                color: rgba(\(Int(linkRed * 100))%, \(Int(linkGreen * 100))%, \(Int(linkBlue * 100))%, \(linkAlpha));
            }
            blockquote {
                text-indent: 2em;
            }
            </style></head><body>
            """
        let styleEnd = """
            \(htmlSuffix ?? "")
            </body></html>
            """

        let html: String
        do {
            guard let success = try SwiftSoup.clean(self, settings.whitelist) else {
                print("RichText: HTML cleaning failed: no exception!")
                return nil
            }
            html = styleStart + success + styleEnd
        } catch {
            print("RichText: HTML cleaning failed: \(String(describing: error))!")
            return nil
        }

        guard let data = html.data(using: RichText.internalEncoding) else {
            print("RichText: HTML encoding to data failed: no exception!")
            return nil
        }

        // Apple recommends this HTML importer only for simple HTML generated by Markdown, etc.
        // https://developer.apple.com/documentation/foundation/nsattributedstring/1524613-init#discussion
        // TODO(Vyr): see if perf impact is real: http://www.robpeck.com/2015/04/nshtmltextdocumenttype-is-slow/
        let mutableAttributedString: NSMutableAttributedString
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: NSNumber(value: RichText.internalEncoding.rawValue),
            ]
        do {
            let success = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            mutableAttributedString = success
        } catch {
            print("RichText: HTML data parsing failed: \(String(describing: error))!")
            return nil
        }
        
        for emoji in emojis {
            let textAttachment = NSTextAttachment()
            textAttachment.loadImageUsingCache(withUrl: emoji.url.absoluteString)
            textAttachment.bounds = CGRect(x: 0, y: Int(-4), width: Int(settings.bodyFont.lineHeight), height: Int(settings.bodyFont.lineHeight))
            let attrStringWithImage = NSAttributedString(attachment: textAttachment)
            while mutableAttributedString.mutableString.contains(":\(emoji.shortcode):") {
                let range: NSRange = (mutableAttributedString.mutableString as NSString).range(of: ":\(emoji.shortcode):")
                mutableAttributedString.replaceCharacters(in: range, with: attrStringWithImage)
            }
        }

        return mutableAttributedString
    }
}
