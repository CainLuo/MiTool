//
//  LocaleX.swift
//  MiTool
//
//  Created by Cain on 2024/3/11.
//

import Foundation

public enum MiHoYoAPILanguage: String, Codable, CaseIterable {
    case thailand = "th-th"
    case korean = "ko-kr"
    case spanish = "es-es"
    case japanese = "ja-jp"
    case chineseSimplified = "zh-cn"
    case indonesian = "id-id"
    case portuguese = "pt-pt"
    case german = "de-de"
    case french = "fr-fr"
    case chineseTraditional = "zh-tw"
    case russian = "ru-ru"
    case englishUS = "en-us"
    case vietnamese = "vi-vn"
}

extension Locale {
    /// Get the language code used for miHoYo API according to current preferred localization.
    public static var miHoYoAPILanguage: MiHoYoAPILanguage {
        switch Bundle.main.preferredLocalizations.first {
        case "zh-Hans":
            return .chineseSimplified
        case "zh-Hant":
            return .chineseTraditional
        case "en":
            return .englishUS
        case "ja":
            return .japanese
        case "ru":
            return .russian
        case "vi":
            return .vietnamese
        case "es":
            return .spanish
        default:
            return .englishUS
        }
    }
}
