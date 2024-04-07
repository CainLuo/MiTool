//
//  LanguageManager.swift
//  MiTool
//
//  Created by Cain on 2024/4/7.
//

import Foundation

class LanguageManager {
    /// Get the language type based on language code and region code
    /// - Returns: String
    static func getLang() -> String {
        let localeIdentifier = Locale.current.identifier
        let components = localeIdentifier.components(separatedBy: "_")
        if components.count >= 1 {
            let languageCode = components[0]
            switch languageCode {
            case "zh":
                if components.count >= 2 {
                    return "zh-\(components[1].lowercased())"
                }
            case "ja":
                return "ja"
            case "ko":
                return "ko"
            case "en":
                return "en"
            default:
                return "zh-cn"
            }
        }
        return "zh-cn"
    }
}
